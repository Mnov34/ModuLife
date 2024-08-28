import 'package:flutter/material.dart';
import 'package:modulife2/home/home.dart';
import 'package:modulife2/profile/profile.dart';
import 'package:modulife2/uikit/uicolors.dart';
import 'package:modulife2/widgets/custom_app_bar.dart';

class ProfileSelectPage extends StatelessWidget {
  const ProfileSelectPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfileSelectPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile selection', profile: null, enableBackButton: false,),
      body: Container(
          color: UiColors.background,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, HomePage.route(),);
                },
                child: const CircleAvatar(
                radius: 63,
                backgroundColor: UiColors.accentColor1,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: UiColors.accentColor2,
                ),
              ),
              ),
              const SizedBox(height: 70),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    ProfileCreationPage.route(),
                  );
                },
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 63,
                      backgroundColor: UiColors.accentColor1,
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor: UiColors.accentColor2,
                          child: Icon(
                            Icons.add,
                            color: UiColors.accentColor1,
                            size: 40,
                          )),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Add a new profile',
                      style: TextStyle(
                        color: UiColors.accentColor1,
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
