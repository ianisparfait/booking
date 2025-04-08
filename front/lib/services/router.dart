import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:booking/screens/home/home_screen.dart";
import "package:booking/screens/settings/settings_screen.dart";
import "package:booking/screens/settings/table_screen.dart";
import "package:booking/screens/settings/room_screen.dart";
import "package:booking/widgets/bottom_navigation_bar.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingsTabNavigatorKey = GlobalKey<NavigatorState>();

Page getPage({
  required Widget child,
  required GoRouterState state,
}) {
  return MaterialPage(
    key: state.pageKey,
    child: child,
  );
}

final router = GoRouter(
  initialLocation: "/home",
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: "/home",
              pageBuilder: (context, GoRouterState state) {
                return getPage(
                  child: const HomeScreen(),
                  state: state,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsTabNavigatorKey,
          routes: [
            GoRoute(
              path: "/settings",
              pageBuilder: (context, state) {
                return getPage(
                  child: const SettingsScreen(),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: "/settings/rooms",
              pageBuilder: (context, state) {
                return getPage(
                  child: const AdminRoomScreen(),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: "/settings/tables",
              pageBuilder: (context, state) {
                return getPage(
                  child: const AdminTableScreen(),
                  state: state,
                );
              },
            ),
          ],
        ),
      ],
      pageBuilder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return getPage(
          child: BottomNavigationPage(
            child: navigationShell,
          ),
          state: state,
        );
      },
    ),
  ],
);
