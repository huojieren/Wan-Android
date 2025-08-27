import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wan_android/common_ui/loading.dart';

enum WebViewType { HTMLTEXT, URL }

typedef dynamic JsChannelCallback(List<dynamic> arguments);

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({
    super.key,
    required this.webViewType,
    required this.loadResource,
    this.jsChannelMap,
    this.onWebViewCreated,
    this.isClearCache,
  });

  final WebViewType webViewType;
  final String loadResource;
  final bool? isClearCache;
  final Map<String, JsChannelCallback>? jsChannelMap;
  final Function(InAppWebViewController controller)? onWebViewCreated;

  @override
  State<StatefulWidget> createState() {
    return _WebViewWidgetState();
  }
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late InAppWebViewController webViewController;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(builtInZoomControls: false, useHybridComposition: true),
    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      key: webViewKey,
      initialOptions: options,
      onWebViewCreated: (controller) {
        webViewController = controller;

        if (widget.isClearCache == true) {
          controller.clearCache();
        }

        if (widget.onWebViewCreated == null) {
          if (widget.webViewType == WebViewType.HTMLTEXT) {
            webViewController.loadData(data: widget.loadResource);
          } else if (widget.webViewType == WebViewType.URL) {
            webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(widget.loadResource)));
          }
        } else {
          widget.onWebViewCreated?.call(controller);
        }

        widget.jsChannelMap?.forEach((handlerName, callback) {
          webViewController.addJavaScriptHandler(handlerName: handlerName, callback: callback);
        });
      },
      onConsoleMessage: (controller, consoleMessage) {
        log("consoleMessage ====来自于js的打印==== \n $consoleMessage");
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {},
      onLoadStart: (InAppWebViewController controller, Uri? url) {
        Loading.showLoading(duration: const Duration(seconds: 45));
      },
      onLoadError: (InAppWebViewController controller, Uri? url, int code, String message) {
        Loading.dismissAll();
      },
      onLoadStop: (InAppWebViewController controller, Uri? url) {
        Loading.dismissAll();
      },
      onPageCommitVisible: (InAppWebViewController controller, Uri? url) {},
    );
  }
}
