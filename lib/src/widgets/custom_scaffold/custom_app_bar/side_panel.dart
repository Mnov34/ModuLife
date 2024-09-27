import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modulife/src/utils/app_router.gr.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text('Quick Navigation')),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.router.navigate(const HomeRoute());
              context.router.maybePop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('TODO list'),
            onTap: () {
              context.router.navigate(const TodoRoute());
              context.router.maybePop();
            },
          ),
        ],
      ),
    );
  }
}
