import 'package:flutter/material.dart';

import 'package:modulife/widgets/custom_app_bar.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (BuildContext _) => const AboutPage());
  }

  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'About',
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
