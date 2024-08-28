import 'package:flutter/material.dart';
import 'package:modulife2/home/home.dart';
import 'package:modulife2/profile/profile.dart';
import 'package:modulife2/splash/splash.dart';

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
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (BuildContext context, Widget? child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            _navigator.pushAndRemoveUntil<void>(
              HomePage.route(),
              (Route<dynamic> route) => false,
            );
          } catch (e) {
            print('Error: $e');
          }
        });
        return child ?? Container();
      },
      onGenerateRoute: (RouteSettings _) => SplashPage.route(),
    );
  }
}
