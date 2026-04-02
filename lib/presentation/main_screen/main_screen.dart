import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_app/presentation/home/widgets/add_task_sheet.dart';

import '../../core/router/route_path.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  final String location;

  const MainScreen({super.key, required this.child, required this.location});

  int _calculateSelectedIndex(String location) {
    if (location.startsWith(RoutePaths.calendar)) return 1;
    if (location.startsWith(RoutePaths.focusMode)) return 2;
    if (location.startsWith(RoutePaths.profile)) return 3;
    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RoutePaths.home);
        break;
      case 1:
        context.go(RoutePaths.calendar);
        break;
      case 2:
        context.go(RoutePaths.focusMode);
        break;
      case 3:
        context.go(RoutePaths.profile);
        break;
    }
  }

  List<Widget> _buildNavItems(BuildContext context, int selectedIndex) {
    final navBarItems = [
      NavBarItem(
        filledIcon: Icons.home_filled,
        outlinedIcon: Icons.home_outlined,
        name: 'Home',
      ),
      NavBarItem(
        filledIcon: Icons.calendar_today_rounded,
        outlinedIcon: Icons.calendar_today_outlined,
        name: 'Calendar',
      ),
      NavBarItem(
        filledIcon: Icons.timer_rounded,
        outlinedIcon: Icons.timer_outlined,
        name: 'Focus',
      ),
      NavBarItem(
        filledIcon: Icons.person,
        outlinedIcon: Icons.person,
        name: 'Profile',
      ),
    ];
    final widgets = <Widget>[];

    for (int i = 0; i < navBarItems.length; i++) {
      if (i == navBarItems.length ~/ 2) {
        widgets.add(const SizedBox(width: 40));
      }

      final item = navBarItems[i];
      final isSelected = selectedIndex == i;

      widgets.add(
        GestureDetector(
          onTap: () => _onTabTapped(context, i),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? item.filledIcon : item.outlinedIcon,
                  color: isSelected ? Colors.blue : Colors.grey,
                ),
                SizedBox(height: 4),
                Text(navBarItems[i].name, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(location);

    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            elevation: 5,
            context: context,
            builder: (context) => AddTaskSheet(),
          );
        },
        tooltip: 'Increment',
        child: Icon(Ionicons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildNavItems(context, selectedIndex),
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
