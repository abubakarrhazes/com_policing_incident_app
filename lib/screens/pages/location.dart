// ignore_for_file: prefer_const_constructors, unused_field, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
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
      ..loadRequest(Uri.parse(
          'https://www.google.com/maps/place/Faculty+of+Physical+and+Computing+Sciences,+Usmanu+Danfodiyo+University,+Sokoto/@13.1290675,5.2149547,17z/data=!3m1!4b1!4m6!3m5!1s0x11b7e71b678d0d5f:0xc404cc7eff916433!8m2!3d13.1290675!4d5.2175296!16s%2Fg%2F11l22qm1p4?entry=ttu'));
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(body: WebViewWidget(controller: controller)));
  }

  // Function to get JavaScriptMode based on the platform
}
