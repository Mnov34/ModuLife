import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:modulife/src/widgets/custom_scaffold/custom_scaffold.dart';

import 'package:modulife_ui_colors/modulife_ui_colors.dart';

@RoutePage()
class ProfileSelectPage extends StatelessWidget {
  const ProfileSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Profile Select',
      body: Container(
          color: UiColors.background,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              RawMaterialButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    RouteUtils.createRoute(page: HomePage()),
                  );*/
                },
                child: const CircleAvatar(
                  radius: 63,
                  backgroundColor: UiColors.primaryColor,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: UiColors.secondaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 70),
              RawMaterialButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    RouteUtils.createRoute(page: const ProfileCreationPage()),
                  );*/
                },
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 63,
                      backgroundColor: UiColors.primaryColor,
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor: UiColors.secondaryColor,
                          child: Icon(
                            Icons.add,
                            color: UiColors.primaryColor,
                            size: 40,
                          )),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Add a new profile',
                      style: TextStyle(
                        color: UiColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ))),
    );
  }
}
