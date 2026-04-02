import 'package:go_router/go_router.dart';
import 'package:todo_app/core/router/route_path.dart';
import 'package:todo_app/presentation/calendar/calendar_page.dart';
import 'package:todo_app/presentation/focus_mode/focus_mode_page.dart';
import 'package:todo_app/presentation/main_screen/main_screen.dart';

import '../../presentation/home/home_page.dart';
import '../../presentation/profile/profile_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.home,

    routes: [
      ShellRoute(
        builder: (cxt, state, child) {
          return MainScreen(location: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: RoutePaths.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: RoutePaths.calendar,
            builder: (context, state) => const CalendarPage(),
          ),
          GoRoute(
            path: RoutePaths.focusMode,
            builder: (context, state) => const FocusModePage(),
          ),
          GoRoute(
            path: RoutePaths.profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}
