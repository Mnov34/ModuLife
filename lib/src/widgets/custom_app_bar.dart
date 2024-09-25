import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:modulife/src/pages/profile/models/models.dart';
import 'package:modulife/src/utils/app_router.gr.dart';
import 'package:modulife_ui_colors/util/colors.dart';

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
      backgroundColor: UiColors.primaryColor,
      title: Row(
        children: [
          if (profile != null) ...[
            const CircleAvatar(
              backgroundColor: UiColors.primaryColor,
              radius: 22,
              child: CircleAvatar(
                  backgroundColor: UiColors.secondaryColor,
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
                context.router.push(const SettingsRoute());
                break;
              case 'about':
                context.router.push(const AboutRoute());
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
