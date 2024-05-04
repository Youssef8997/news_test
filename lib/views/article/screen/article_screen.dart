import 'dart:io';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hamazh_auth/data/model/articles_model.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';
import 'package:hamazh_auth/utls/manger/fonts_manger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utls/manger/assets_manger.dart';

class ArticlesScreen extends StatefulWidget {
  final ArticlesModel articles;

  const ArticlesScreen({super.key, required this.articles});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  WebViewController controller = WebViewController();
  String path = "";

  Future getPathAndGetData() async {
    Directory? directory = await getApplicationCacheDirectory();

    path = "${directory.path}/${widget.articles.url.split("/").last}";

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadFile(path);
  }

  @override
  void initState() {
    if (ConnectionNotifierTools.isConnected) {
      context.homeCuibt.saveArticle(widget.articles.url);

      controller
        ..setJavaScriptMode(JavaScriptMode.disabled)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(
          Uri.parse(
              "${widget.articles.url}?api-key=NgGTUayqkspuPvoLSy0K7DnLAU3bVcNA"),
        );
    } else {
      getPathAndGetData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 50,
        leadingWidth: 100,
        actions: [
          Image.asset(
            AssetsManger.newYorkTimeLogo,
            height: 50,
            width: 100,
          ),
        ],
        title: Text(
          "the new york times",
          style: FontsManger.largeFont(context).copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
