import 'package:flutter/material.dart';

import 'package:modulife/about/about.dart';
import 'package:modulife/profile/models/models.dart';
import 'package:modulife/settings/settings.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.profile,
    required this.isBackButtonEnabled,
  });

  final String title;
  final Profile? profile;
  final bool isBackButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: UiColors.accentColor1,
      title: Row(
        children: [
          if (profile != null) ...[
            const CircleAvatar(
              backgroundColor: UiColors.accentColor1,
              radius: 22,
              child: CircleAvatar(
                backgroundColor: UiColors.accentColor2,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Text(title),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          offset: const Offset(0, 43),
          onSelected: (String result) {
            switch (result) {
              case 'settings':
                Navigator.of(context).pop();
                SettingsPage.route();
                break;
              case 'about':
                Navigator.of(context).pop();
                AboutPage.route();
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'settings',
              child: Row(
                children: [
                  Icon(Icons.settings, color: Colors.black),
                  SizedBox(width: 10),
                  Text('Settings'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'about',
              child: Row(
                children: [
                  Icon(Icons.question_mark, color: Colors.black),
                  SizedBox(width: 10),
                  Text('about'),
                ],
              ),
            ),
          ],
        ),
      ],
      automaticallyImplyLeading: isBackButtonEnabled,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
