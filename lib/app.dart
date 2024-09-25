import 'package:flutter/material.dart';

import 'package:modulife/utils/app_router.dart';
import 'package:modulife_ui_colors/util/colors.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(scaffoldBackgroundColor: UiColors.background),
      //onGenerateRoute: (RouteSettings _) => RouteUtils.createRoute(page: const SplashPage()),
    );
  }
}
