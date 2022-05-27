/*
 * @Author: lixiao
 * @Date: 
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: webview
 * @FilePath: 
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String? url;
  final String title;
  final bool? isLocalUrl;

  late WebViewController _webViewController;

  WebViewPage(
      {Key? key, this.url, required this.title, this.isLocalUrl = false})
      : super(key: key);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState
    extends State<WebViewPage> /*with AutomaticKeepAliveClientMixin*/ {
  // var _id;
  // bool get wantKeepAlive => true;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    // this._id = widget._productContentList[0].sId;
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffff0044),
      leading: IconButton(
        icon: Image.asset(
          "images/navi_back_images.png",
          fit: BoxFit.cover,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        widget.title != null ? widget.title : "webView",
        // "webview",
        style: TextStyle(
          color: Color(0xff333333),
          fontSize: 18.0,
        ),
      ),
    );
  }

  _buildBody() {
    return Container(
      child: Column(
        children: [
          //  Expanded(
          //     child: InAppWebView(
          //           // initialUrl: "http://jd.itying.com/pcontent?id=${ this._id}",
          //            initialUrlRequest:
          //               URLRequest(url: Uri.parse("http://jd.itying.com/pcontent?id=${ this._id}")),
          //           onProgressChanged: (InAppWebViewController controller, int progress) {

          //           },
          //   ),
          Expanded(
            child: WebView(
              // initialUrl:
              //     "http://jd.itying.com/pcontent?id=5a0425bc010e711234661439",
              // initialUrl: "https://webapp.xinwenda.net/privacy",
              // initialUrl: widget.isLocalUrl
              //     ? Uri.dataFromString(widget.url,
              //             mimeType: 'text/html',
              //             encoding: Encoding.getByName('utf-8'))
              //         .toString()
              //     : widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);

                widget._webViewController = webViewController;
                if (widget.isLocalUrl!) {
                  _loadHtmlAssets(webViewController);
                } else {
                  webViewController.loadUrl(widget.url!);
                }
                webViewController
                    .canGoBack()
                    .then((value) => debugPrint(value.toString()));
                webViewController
                    .canGoForward()
                    .then((value) => debugPrint(value.toString()));
                webViewController
                    .currentUrl()
                    .then((value) => debugPrint(value));
              },
              onProgress: (int progress) {
                print("WebView is loading (progress : $progress%)");
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
                jsBridge(context),
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                // if (request.url.startsWith('https://webapp.xinwenda.net/')) {
                //   print('blocking navigation to $request}');
                //   return NavigationDecision.prevent;
                // }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');

                widget._webViewController
                    .evaluateJavascript('document.title')
                    .then((title) {
                  print("title = ${title}");
                });
              },
              gestureNavigationEnabled: true,
            ),
          ),
        ],
      ),
    );
  }

  //加载本地文件
  _loadHtmlAssets(WebViewController controller) async {
    String htmlPath = await rootBundle.loadString(widget.url!);
    controller.loadUrl(Uri.dataFromString(htmlPath,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
      name: 'jsbridge', // 与h5 端的一致 不然收不到消息
      onMessageReceived: (JavascriptMessage message) async {
        debugPrint(message.message);
      });
}
