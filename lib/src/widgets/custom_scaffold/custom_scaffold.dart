import 'package:flutter/material.dart';
import 'custom_app_bar/barrel.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  //final Profile? profile;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    //this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        profile: null,
      ),
      drawer: const SidePanel(),
      body: body,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
