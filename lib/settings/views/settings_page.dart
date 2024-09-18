import 'package:flutter/material.dart';

import 'package:modulife/widgets/custom_app_bar.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (BuildContext _) => const SettingsPage());
  }

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
        profile: null,
        isBackButtonEnabled: true,
      ),
      body: Stack(
        children: [
          Container(
            color: UiColors.background,
          ),
        ],
      ),
    );
  }
}
