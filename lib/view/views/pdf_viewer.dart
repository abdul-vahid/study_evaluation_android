import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:study_evaluation/utils/function_lib.dart';

import '../../utils/app_color.dart';

class PDFViewer extends StatefulWidget {
  final String? path;

  const PDFViewer({Key? key, this.path}) : super(key: key);

  @override
  PDFViewerState createState() => PDFViewerState();
}

class PDFViewerState extends State<PDFViewer> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
        backgroundColor: AppColor.appBarColor,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: true,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              //debug(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              //  debug('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              //debug('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              //debug('page change: $page/$total');
              setState(() {
                currentPage = page! + 1;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("$currentPage/$pages"),
              onPressed: () async {
                currentPage =
                    currentPage == pages ? currentPage : currentPage! + 1;
                //debug("curretnPage == $currentPage");
                await snapshot.data!.setPage(currentPage! - 1);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
