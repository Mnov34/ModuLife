import 'package:auto_route/auto_route.dart';

import 'package:modulife/src/utils/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: TodoRoute.page),
        AutoRoute(page: AboutRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
