import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../screens/HomeScreen.dart';
import '../screens/MenuScreen.dart';
import '../screens/ScheduleScreen.dart';
import '../screens/AppointmentsScreen.dart';

class ParentScreen extends StatefulWidget {

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);

  Map<String, Widget> _pages = {
    "Home" : HomeScreen(),
    "Sessions" : AppointmentsScreen(),
    "Schedule" : ScheduleScreen(),
    "Menu" :MenuScreen(),
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        controller: _pageController,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: navBar(context),
    );
  }

  Widget navBar(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: BottomNavigationBar(
          elevation: 20,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            );
            setState(() => _selectedIndex = index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.home,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                _pages.keys.elementAt(0),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.sticky_note,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                _pages.keys.elementAt(1),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.history,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                _pages.keys.elementAt(2),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.bars,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                _pages.keys.elementAt(3),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

}