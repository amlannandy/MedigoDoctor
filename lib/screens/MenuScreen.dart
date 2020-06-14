import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../models/MenuItem.dart';
import '../widgets/UserInfo.dart';
import '../widgets/MenuItem.dart';
import '../services/FirebaseAuthenticationService.dart';

class MenuScreen extends StatelessWidget {

  static final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();

  final List<MenuItem> menuItems = [
    MenuItem(
      title: 'Profile',
      icon: LineIcons.user,
      onPress: (context) => Navigator.of(context).pushNamed('/profile'),
    ),
    MenuItem(
      title: 'Appointment History',
      icon: LineIcons.history,
      onPress: () {},
    ),
    MenuItem(
      title: 'Share with Friends',
      icon: LineIcons.share,
      onPress: () {},
    ),
    MenuItem(
      title: 'Log out',
      icon: LineIcons.sign_out,
      onPress: (context) => _auth.logOut(context),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserInfo(),
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (ctx, index) => MenuItemWidget(menuItems[index]),
            itemCount: menuItems.length,
          ),
        ),
      ],
    );
  }
}
