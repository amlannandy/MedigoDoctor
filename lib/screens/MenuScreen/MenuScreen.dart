import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../models/MenuItem.dart';
import '../../models/WebViewArgs.dart';
import './local_widgets/MenuItem.dart';
import '../../services/FirebaseAuthenticationService.dart';

class MenuScreen extends StatelessWidget {

  static final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();

  static void shareHandler(BuildContext context) {
    Share.share(
      'Connect to experienced doctors with one click!',
      subject: 'Check out MediGo!'
    );
  }

  static void openWebView(BuildContext context, {String title, String url}) {
    Navigator.of(context).pushNamed(
      '/webview', arguments: WebViewArgs(
        title: title,
        url: url,
      )
    );
  }

  final List<MenuItem> menuItems = [
    MenuItem(
      title: 'Edit Profile',
      icon: LineIcons.user,
      onPress: null,
    ),
    MenuItem(
      title: 'Consultation History',
      icon: LineIcons.history,
      onPress: () {},
    ),
    MenuItem(
      title: 'MediLocker',
      icon: LineIcons.lock,
      onPress: () {},
    ),
    MenuItem(
      title: 'Share with Friends',
      icon: LineIcons.share,
      onPress: shareHandler,
    ),
    MenuItem(
      title: 'Terms & Conditons',
      icon: LineIcons.share_alt,
      onPress: (context) => openWebView(
        context,
        title: 'Terms and Conditions',
        url: 'https://www.google.co.in'
      ),
    ),
    MenuItem(
      title: 'Privacy Policy',
      icon: LineIcons.bookmark_o,
      onPress: (context) => openWebView(
        context,
        title: 'Privacy Policy',
        url: 'https://www.google.co.in'
      ),
    ),
    MenuItem(
      title: 'Log out',
      icon: LineIcons.sign_out,
      onPress: _auth.logOut,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          for (var item in menuItems) MenuItemWidget(item)
        ],
      ),
    );
  }
}
