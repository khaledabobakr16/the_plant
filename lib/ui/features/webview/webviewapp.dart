import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../home/weather_screen.dart';
import 'widgets/mywebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse("https://oxymanager.com/auth/"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 2,
        leading:IconButton(
          onPressed: (){
             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const Home()));
          },
          icon: const Icon(
                Icons.arrow_back_ios,
              ),
        ) ,
        actions: [
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await controller.canGoBack()) {
                await controller.goBack();
              } else {
                messenger.showSnackBar(

                    const SnackBar(content: Text("No Back History Found",),backgroundColor: cBlue,));
                return;
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await controller.canGoForward()) {
                await controller.goForward();
              } else {
                messenger.showSnackBar(
                    const SnackBar(content: Text("No Forward History Found"),backgroundColor: cBlue,));
                return;
              }
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: const Icon(Icons.replay))
        ],
      ),
      body: SafeArea(
        child:MyWebViewWidget(
        controller: controller,
      ),
      ),
    );
  }
}
