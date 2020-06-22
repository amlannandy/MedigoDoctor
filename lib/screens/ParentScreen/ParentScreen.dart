import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import './local_widgets/CustomAppBar.dart';
import '../../screens/HomeScreen/HomeScreen.dart';
import '../../screens/MenuScreen/MenuScreen.dart';
import '../../screens/ScheduleScreen/screens/ScheduleScreen.dart';
import '../../screens/AppointmentsScreen/AppointmentsScreen.dart';

class ParentScreen extends StatefulWidget {

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);

  Map<String, Widget> _pages = {
    "Home" : HomeScreen(),
    "Chats" : AppointmentsScreen(),
    "Doctors" : ScheduleScreen(),
    "Menu" : MenuScreen(),
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: customAppBar(context, userId),
      body: PageView(
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        controller: _pageController,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: googleNavBar(context),
    );
  }

  Widget googleNavBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 5,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Theme.of(context).primaryColor,
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.comment,
                text: 'Sessions',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.history,
                text: 'Schedule',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.bars,
                text: 'Menu',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              setState(() {
                _selectedIndex = index;
              });
            }
          ),
        ),
      ),
    );
  }

}