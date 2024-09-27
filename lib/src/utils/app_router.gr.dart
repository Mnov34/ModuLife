// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:modulife/src/pages/about/views/about_page.dart' as _i1;
import 'package:modulife/src/pages/feedback/views/bug_report_page.dart' as _i2;
import 'package:modulife/src/pages/home/view/home_page.dart' as _i3;
import 'package:modulife/src/pages/profile/views/profile_select_page.dart'
    as _i4;
import 'package:modulife/src/pages/settings/views/settings_page.dart' as _i5;
import 'package:modulife/src/pages/todos/views/todos_page.dart' as _i6;

/// generated route for
/// [_i1.AboutPage]
class AboutRoute extends _i7.PageRouteInfo<void> {
  const AboutRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AboutRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutPage();
    },
  );
}

/// generated route for
/// [_i2.BugReportPage]
class BugReportRoute extends _i7.PageRouteInfo<void> {
  const BugReportRoute({List<_i7.PageRouteInfo>? children})
      : super(
          BugReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'BugReportRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.BugReportPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.ProfileSelectPage]
class ProfileSelectRoute extends _i7.PageRouteInfo<void> {
  const ProfileSelectRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProfileSelectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileSelectRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.ProfileSelectPage();
    },
  );
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SettingsPage();
    },
  );
}

/// generated route for
/// [_i6.TodoPage]
class TodoRoute extends _i7.PageRouteInfo<void> {
  const TodoRoute({List<_i7.PageRouteInfo>? children})
      : super(
          TodoRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i6.TodoPage());
    },
  );
}
