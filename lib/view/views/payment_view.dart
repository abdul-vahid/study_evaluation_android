import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/app_constants.dart';

class PaymentView extends StatefulWidget {
  final bs64;
  const PaymentView({super.key, this.bs64});

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

WebViewController? controllerGlobal;

Future<bool> _exitApp(BuildContext context) async {
  print("Current Url: ${controllerGlobal?.currentUrl()}");
  controllerGlobal?.currentUrl().then((value) {
    //print("value == $value");
    //var endPoint = "${AppConstants.baseUrl}/study_evaluation_website/callback";

    if (value != null && value.contains(AppConstants.baseUrl)) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("First complete the payment process then go back")));
    }
  });

  // if (await controllerGlobal!.canGoBack()) {
  //   print("Current Url: ${controllerGlobal?.currentUrl()}");
  //   //controllerGlobal!.goBack();
  // } else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("No back history item")),
  //   );
  //   return Future.value(false);
  // }
  return Future.value(false);
}

class _PaymentViewState extends State<PaymentView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Payment'),
          // // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
          actions: <Widget>[
            NavigationControls(_controller.future),
            //  SampleMenu(_controller.future),
          ],
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl:
                '${AppConstants.baseUrl}/study_evaluation_website/checkout?m=${widget.bs64}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            // TODO(iskakaushik): Remove this when collection literals makes it to stable.
            // ignore: prefer_collection_literals
            javascriptChannels: <JavascriptChannel>[
              _toasterJavascriptChannel(context),
            ].toSet(),
            navigationDelegate: (NavigationRequest request) {
              // if (request.url.startsWith('https://www.youtube.com/')) {
              //   print('blocking navigation to $request}');
              //   return NavigationDecision.prevent;
              // }
              // if (request.url.startsWith('https://flutter.dev/docs')) {
              //   print('blocking navigation to $request}');
              //   return NavigationDecision.prevent;
              // }
              // print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
          );
        }),
        //  floatingActionButton: favoriteButton(),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String? url = await controller.data!.currentUrl();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        controllerGlobal = controller;

        return Row(
          children: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.arrow_back_ios),
            //   onPressed: !webViewReady
            //       ? null
            //       : () async {
            //           if (await controller!.canGoBack()) {
            //             controller.goBack();
            //           } else {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(content: Text("No back history item")),
            //             );
            //             return;
            //           }
            //         },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.arrow_forward_ios),
            //   onPressed: !webViewReady
            //       ? null
            //       : () async {
            //           if (await controller!.canGoForward()) {
            //             controller.goForward();
            //           } else {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                   content: Text("No forward history item")),
            //             );
            //             return;
            //           }
            //         },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.replay),
            //   onPressed: !webViewReady
            //       ? null
            //       : () {
            //           controller!.reload();
            //         },
            // ),
          ],
        );
      },
    );
  }
}
