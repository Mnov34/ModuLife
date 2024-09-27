import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'package:modulife/src/widgets/custom_scaffold/custom_scaffold.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'About',
      body: Container(),
    );
  }
}
