import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:billDeskSDK/sdk.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/sdk_context.dart';
import '../utilities/OrderConfigValidator.dart';
import '../utilities/sdk_logger.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();

  late SdkPresenter presenter;
  Rx<bool> bdModelShouldModalClose = false.obs;
  late SdkConfig sdkConfig;
  late SDKWebviewController sdkWebViewController;
  late InAppWebViewController inAppWebViewController;
  RxDouble progress = 0.0.obs;
  late BuildContext context;
  late Response response;
  final GlobalKey webViewKey = GlobalKey();
  late FlowType flowType;
  RxBool isDone = false.obs;
  bool isSdkExecuted = false;
  late String url;
  List<String> urls = [];

  @override
  onInit() async {
    super.onInit();
    await initializeSdk();
    debounce(bdModelShouldModalClose, (shouldModalClose) {
      if (shouldModalClose == true) {
        sdkWebViewController.exitAndInvokeCallback(false, presenter, context);
      }
    });
  }

  Future<void> initializeSdk() async {
    sdkConfig = Get.arguments;

    SdkLogger.init(level: Level.debug, isUAT: sdkConfig.isUATEnv!);

    sdkWebViewController = SDKWebviewController(this.sdkConfig);

    SdkLogger.i("SDK initialized successfully!");

    try {
      if (!sdkConfig.isJailBreakAllowed) {
        await sdkWebViewController.checkJailBreakOrRootStatus();
      } else {
        SdkLogger.w(
            "Warning: Currently IsJailbreakAllowed flag is enabled in the SDK config. Please disable it in production environment");
      }

      if (!sdkConfig.isDevModeAllowed) {
        await sdkWebViewController.checkDevModeStatus();
      }

      if (sdkConfig.isDevModeAllowed && Platform.isAndroid) {
        SdkLogger.w(
            "Warning: Currently IsDevModeAllowed flag is enabled in the SDK config. Please disable it in production environment");
      }

      SdkConfiguration config = sdkConfig.sdkConfigJson;

      flowType = config.flowType!;

      if (flowType == FlowType.payment_plus_mandate) {
        config.flowType = flowType = FlowType.payments;
      }

      try {
        OrderConfigValidator.validateOrderConfig(config);
      } on SdkException catch (e) {
        sdkConfig.responseHandler.onError(e.sdkError);
      }

      sdkWebViewController.paymentsConfig = config.flowConfig!;

      presenter = SdkPresenter(
        sdkContext: SdkContext(scope: Scope()),
      );

      loadConfiguration();

      //* getOrder details api call
      try {
        Response? response;
        response = await sdkWebViewController.getApiResponse(
            flowType, response, presenter);

        presenter.sdkContext?.scope.set("orderResponse", response);

        assert(BuildConfig.filePath.isNotEmpty, "filePath must be initialized");

        sdkWebViewController.loading.value = false;
      } catch (e) {
        SdkError sdkError = SdkError(
            msg: 'Some exception occurred while loading web view.',
            description: e.toString(),
            SDK_ERROR: SdkError.SERVICE_ERROR);
        SdkLogger.e(e.toString());
        sdkConfig.responseHandler.onError(sdkError);
      }
    } catch (e) {
      Navigator.of(context).pop();
      SdkLogger.e(e.toString());
      if (e is SdkException) {
        sdkConfig.responseHandler.onError(e.sdkError);
      }
    }
  }

  loadConfiguration() async {
    if (BuildConfig.filePath.isEmpty) {
      await BuildConfig.loadConfig(isUATEnv: sdkConfig.isUATEnv);
    }
  }

  getInAppWebViewInstance(BuildContext context) {
    this.context = context;

    return [
      InAppWebView(
        key: webViewKey,
        initialOptions: getInAppWebviewOptions(),
        initialFile: BuildConfig.filePath,
        onWebViewCreated: setWebViewController,
        onLoadStart: _updateParams,
        onProgressChanged: progressListener,
        onLoadStop: _loadWebPage,
        onLoadResource: loadResourceHandler,
        onLoadError: pageLoadErrorListener,
        onLoadHttpError: httpErrorListener,
        shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
        onReceivedServerTrustAuthRequest: setCertificateToSite,
        androidOnPermissionRequest: androidPermissionRequest,
        onCreateWindow: setChildWindow,
        onCloseWindow: (controller) async {
          await inAppWebViewController.evaluateJavascript(
              source: "window.localStorage.clear();");
        },
      ),
      Obx(() => isDone.isFalse ? LinearProgressIndicator() : Container())
    ];
  }

  loadResourceHandler(
      InAppWebViewController controller, LoadedResource resource) async {
    if (resource.url.toString().contains(".js") && !isSdkExecuted) {
      executeSdkModal(controller);
    }
  }

  executeSdkModal(InAppWebViewController controller) async {
    try {
      var json = sdkConfig.sdkConfigJson.toJson();
      _filterJsonProperty(json);
      var config = jsonEncode(json);

      await controller.evaluateJavascript(source: """

                  if(typeof sdkStatus == 'undefined'){
                    sdkStatus = {"isExecuted": false};
                  }

                 if(typeof window.loadBillDeskSdk === 'function' && !sdkStatus["isExecuted"]){
                  
                  sdkStatus["isExecuted"] = true;
                   window.flutter_inappwebview.callHandler("sdkExecutionEvent", JSON.stringify(sdkStatus));

                         var sdkConfig = ${config}
                     sdkConfig["responseHandler"] = function(response){
                       window.location.href = "billdesksdk://web-flow?status=" + response.status + "&response=" + response.txnResponse;
                       };
                      sdkConfig['flowConfig']['returnUrl'] = "" ;
                      sdkConfig['flowConfig']['childWindow'] = false;
                      
                      window.loadBillDeskSdk(sdkConfig);
                      
                      }
           """);
    } catch (e) {
      SdkError sdkError = SdkError(
          msg: 'Error during loading BillDeskSdk in WebView',
          description: e.toString(),
          SDK_ERROR: SdkError.SERVICE_ERROR);
      SdkLogger.e('Error during loading BillDeskSdk in WebView', e.toString());
      sdkConfig.responseHandler.onError(sdkError);
    }
  }

  Future<bool?> setChildWindow(InAppWebViewController controller,
      CreateWindowAction createWindowRequest) async {
    RxString currentTitle = 'Redirecting...'.obs;
    RxInt currentProgress = 0.obs;

    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (!await inAppWebViewController.canGoBack()) {
              final shouldNavigateBack = await showConfirmationDialog(context);
              if (shouldNavigateBack == true) {
                return true;
              }
              return false;
            }
            return true;
          },
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                iconTheme: IconThemeData(color: Color(0xff001e2e)),
                shadowColor: Colors.white,
                title: Obx(() => Text(currentTitle.value,
                    style: TextStyle(color: Color(0xff001e2e)))),
                backgroundColor: Color(0xfff7f7f9),
              ),
              body: SafeArea(
                  child: Stack(
                children: [
                  InAppWebView(
                      initialOptions: InAppWebViewGroupOptions(
                          ios: IOSInAppWebViewOptions(
                        enableViewportScale: true,
                      )),
                      windowId: createWindowRequest.windowId,
                      onReceivedServerTrustAuthRequest: setCertificateToSite,
                      onProgressChanged: (controller, progress) {
                        currentProgress.value = progress;
                      },
                      onTitleChanged: (controller, title) {
                        currentTitle.value = title ?? currentTitle.value;
                      },
                      onCloseWindow: (controller) {
                        Navigator.of(context).pop();
                      },
                      onLoadHttpError: httpErrorListener,
                      onLoadError: pageLoadErrorListener),
                  Obx(() => currentProgress != 100
                      ? LinearProgressIndicator()
                      : Container())
                ],
              ))),
        );
      },
    );
    return true;
  }

  InAppWebViewGroupOptions getInAppWebviewOptions() {
    return InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptCanOpenWindowsAutomatically: true,
          useOnLoadResource: true,
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
            supportMultipleWindows: true, useHybridComposition: true),
        ios: IOSInAppWebViewOptions(
            automaticallyAdjustsScrollIndicatorInsets: true,
            allowsInlineMediaPlayback: true,
            enableViewportScale: true,
            alwaysBounceHorizontal: true));
  }

  Future<PermissionRequestResponse> androidPermissionRequest(
      InAppWebViewController controller,
      String origin,
      List<String> resources) async {
    return PermissionRequestResponse(
        resources: resources, action: PermissionRequestResponseAction.GRANT);
  }

  void _updateParams(InAppWebViewController controller, Uri? uri) {
    //url = uri.toString();

    controller.addJavaScriptHandler(
        handlerName: "sdkExecutionEvent",
        callback: (args) {
          Map<String, bool> sdkStatus = jsonDecode(args[0]);

          if (sdkStatus["isExecuted"]!) {
            isSdkExecuted = true;
          }
        });

    Response? orderDetails = presenter.sdkContext?.scope.get("orderResponse");
    String? redirectUrl = orderDetails?.body?['ru'];

    if (redirectUrl != null && uri.toString().startsWith(redirectUrl)) {
      presenter.sdkContext?.scope
          .set("final_response.isCancelledByUser", false);
      presenter.sdkContext?.scope.set("bd-modal.shouldModalClose", true);

      bdModelShouldModalClose.value = true;
    }
  }

  void _loadWebPage(InAppWebViewController controller, Uri? uri) async {
    if (uri.toString().contains("billdesksdk://web-flow")) {
      controller.evaluateJavascript(source: """
                    document.getElementById("loading-info").innerText = "Processing payment. please wait. Don't click back or refresh the page"
                  """).then((value) async {
        Map<String, String> params = Uri.parse(uri.toString()).queryParameters;
        presenter.sdkContext?.scope.set("final_response.isCancelledByUser",
            _getSdkState(params["status"]!));
        presenter.sdkContext?.scope.set("bd-modal.shouldModalClose", true);
        bdModelShouldModalClose.value = true;
        isDone.value = false;

        await Future.delayed(Duration(seconds: 2));

        controller.clearCache();
        sdkWebViewController.exitAndInvokeCallback(false, presenter, context);
      });
    } else if (Platform.isAndroid &&
        uri.toString().contains(BuildConfig.filePath)) {
      if (!isSdkExecuted) executeSdkModal(controller);
    }
  }

  _filterJsonProperty(Map<String, dynamic> json) {
    json["flowConfig"].remove("orderid");
    json["flowConfig"].remove("mandate_tokenid");

    if (json["flowType"] == "e_mandate") {
      json["flowType"] = "emandate";
    }

    return json;
  }

  setWebViewController(InAppWebViewController controller) {
    inAppWebViewController = controller;
  }

  progressListener(controller, progress) {
    if (progress == 100) {
      isDone.value = true;
    }
    this.progress.value = progress;
  }

  pageLoadErrorListener(controller, url, code, message) {
    SdkLogger.e(
        "controller: $controller, url: $url, code: $code, message:$message");
  }

  httpErrorListener(controller, url, statusCode, description) {
    SdkLogger.e(
        "controller: $controller, url: $url, code: $statusCode, description: $description");
  }

  Future<ServerTrustAuthResponse?> setCertificateToSite(
      InAppWebViewController controller,
      URLAuthenticationChallenge challenge) async {
    var dialogResponse = null;

    String url = challenge.protectionSpace.host;

    var sslError = challenge.protectionSpace.sslError;

    String? sslErrorMessage = sslError?.message;

    var isValidError = sslError?.iosError != IOSSslError.UNSPECIFIED;

    if (!url.contains("${BuildConfig.filePath}") &&
        !urls.contains(url) &&
        isValidError) {
      urls.add(url.toString());

      dialogResponse = await showDialog<ServerTrustAuthResponseAction>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('SSL Error'),
            content:
                Text('Ssl Certificate Error: $sslErrorMessage!\n Url : $url'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(ServerTrustAuthResponseAction.CANCEL);
                },
              ),
              TextButton(
                child: Text('Proceed'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(ServerTrustAuthResponseAction.PROCEED);
                },
              ),
            ],
          );
        },
      );
      SdkLogger.e('Ssl Certificate Error: $sslErrorMessage!\n Url : $url');
    }

    if (dialogResponse == ServerTrustAuthResponseAction.CANCEL) {
      controller.clearCache();
      sdkWebViewController.exitAndInvokeCallback(false, presenter, context,
          isSSLError: true);
    }
    // Return the appropriate action based on the user's choice
    return ServerTrustAuthResponse(
        action: dialogResponse ?? ServerTrustAuthResponseAction.PROCEED);
  }

  Future<NavigationActionPolicy?> _shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    Uri uri = navigationAction.request.url!;

    if (!["http", "https", "file", "chrome", "data", "javascript", "about"]
        .contains(uri.scheme)) {
      if (uri.toString().contains("billdesksdk://web-flow")) {
        Map<String, String> params = Uri.parse(uri.toString()).queryParameters;
        presenter.sdkContext?.scope.set("final_response.isCancelledByUser",
            _getSdkState(params["status"]!));
        presenter.sdkContext?.scope.set("bd-modal.shouldModalClose", true);
        bdModelShouldModalClose.value = true;
        return NavigationActionPolicy.CANCEL;
      }
      if (Platform.isAndroid) {
        sdkWebViewController.upiFlowTriggered =
            RegExp(r"(upi|intent)", caseSensitive: false)
                .hasMatch(uri.toString());

        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  bool _getSdkState(String status) {
    var sdkState = SdkState.getSdkStateNameByCode(status.toString());
    if (sdkState == SdkState.PAYMENT_ATTEMPTED) {
      return false;
    }
    return true;
  }

  showConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(16.0),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Abort Payment?'),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Allow navigation back
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        backgroundColor: Colors.white,
                        elevation: 4,
                        padding: EdgeInsets.all(10),
                        minimumSize: Size(100, 0),
                      ),
                      child: Text('Yes'),
                    ),
                  ),
                  SizedBox(width: 16.0), // Add spacing between buttons
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(false); // Cancel navigation back
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        elevation: 4,
                        padding: EdgeInsets.all(10),
                        minimumSize: Size(100, 0),
                      ),
                      child: Text('No'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
