import 'package:flutter/material.dart';
import 'package:modulife2/profile/models/models.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.profile, required this.isBackButtonEnabled});

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
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.black),
          onPressed: () {
            // TODO Implement settings page
          },
        )
      ],
      automaticallyImplyLeading: isBackButtonEnabled,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}