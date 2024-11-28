import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Box_Chat extends StatefulWidget {

  const Box_Chat({super.key});

  @override
  Box_Chat_State createState() => Box_Chat_State();
}

class Box_Chat_State extends State<Box_Chat> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    _clearCookies();
  }

  void _clearCookies() async {
    final cookieManager = WebViewCookieManager();
    await cookieManager.clearCookies();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Không thể thực hiện cuộc gọi đến $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ phận CSKH'),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.phone, color: Colors.black,),
          //   onPressed: () => _makePhoneCall(''),
          // ),
          // IconButton(
          //   icon: const Icon(Icons.videocam, color: Colors.black,),
          //   onPressed: () => _makePhoneCall(''),
          // ),
        ],
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
        // ..loadRequest(Uri.parse('https://tawk.to/chat/66fa4b574cbc4814f7e0d1d5/1i91286i6')),
          ..loadRequest(Uri.parse('https://go.crisp.chat/chat/embed/?website_id=f25dfe6c-0d53-4379-9166-a56f64d6bd53')),
      ),
    );
  }
}

