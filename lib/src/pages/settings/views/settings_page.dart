import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'package:modulife/src/widgets/custom_scaffold.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Settings',
      body: Container(),
    );
  }
}
