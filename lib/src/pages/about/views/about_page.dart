import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'package:modulife/src/widgets/custom_app_bar.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

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
      body: Container(),
    );
  }
}
