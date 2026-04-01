import 'package:flutter/material.dart';
import 'package:todo_app/presentation/calendar/calendar_page.dart';
import 'package:todo_app/presentation/focus_mode/focus_mode_page.dart';
import 'package:todo_app/presentation/home/home_page.dart';
import 'package:todo_app/presentation/profile/profile_page.dart';
import 'package:todo_app/presentation/task/task_page.dart';

import 'package:ionicons/ionicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    CalendarPage(),
    TaskPage(),
    FocusModePage(),
    ProfilePage(),
  ];

  final List<NavBarItem> _navBarItems = [
    NavBarItem(
      filledIcon: Ionicons.home,
      outlinedIcon: Ionicons.home_outline,
      name: "Home",
    ),
    NavBarItem(
      filledIcon: Ionicons.calendar,
      outlinedIcon: Ionicons.calendar_outline,
      name: "Calendar",
    ),
    NavBarItem(
      filledIcon: Ionicons.timer,
      outlinedIcon: Ionicons.timer_outline,
      name: "Focus",
    ),
    NavBarItem(
      filledIcon: Ionicons.person,
      outlinedIcon: Ionicons.person_outline,
      name: "Profile",
    ),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _buildNavItems() {
    List<Widget> widgets = [];

    for (int i = 0; i < _navBarItems.length; i++) {
      if (i == _navBarItems.length ~/ 2) {
        widgets.add(const SizedBox(width: 40));
      }

      final item = _navBarItems[i];

      int screenIndex = i < 2 ? i : i + 1;

      widgets.add(
        GestureDetector(
          onTap: () => _onTabTapped(screenIndex),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _currentIndex == screenIndex
                    ? item.filledIcon
                    : item.outlinedIcon,
                color: _currentIndex == screenIndex ? Colors.blue : Colors.grey,
              ),
              SizedBox(height: 4),
              Text(_navBarItems[i].name, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        tooltip: 'Increment',
        child: Icon(Ionicons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildNavItems(),
        ),
      ),
    );
  }
}

class NavBarItem {
  final IconData filledIcon;
  final IconData outlinedIcon;
  final String name;

  NavBarItem({
    required this.filledIcon,
    required this.outlinedIcon,
    required this.name,
  });
}
