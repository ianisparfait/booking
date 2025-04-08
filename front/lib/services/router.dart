import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:booking/screens/home/home_screen.dart";
import "package:booking/screens/onboarding/login_screen.dart";
import "package:booking/screens/onboarding/register_screen.dart";
import "package:booking/screens/profile/change_password_screen.dart";
import "package:booking/screens/profile/profile_screen.dart";
import "package:booking/widgets/bottom_navigation_bar.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _profileTabNavigatorKey = GlobalKey<NavigatorState>();

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
          navigatorKey: _profileTabNavigatorKey,
          routes: [
            GoRoute(
              path: "/profile",
              pageBuilder: (context, state) {
                return getPage(
                  child: const ProfileScreen(),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: "/change-password",
              pageBuilder: (context, state) {
                return getPage(
                  child: const ChangePasswordScreen(),
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
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/login",
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LoginScreen()),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/register",
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
