import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../../models/WebViewArgs.dart';

class WebViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final WebViewArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: appBar(context, args.title),
      backgroundColor: Colors.white,
      body: WebviewScaffold(
        url: args.url,
      ),
    );
  }

  Widget appBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 22,
          color: Colors.black.withOpacity(0.8),
          fontWeight: FontWeight.bold
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black.withOpacity(0.8),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      bottom: PreferredSize(child: Container(color: Colors.black.withOpacity(0.8), height: 0.4,), preferredSize: Size.fromHeight(4.0)),
    );
  }
}