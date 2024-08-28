import 'package:flutter/material.dart';
import 'package:modulife2/profile/models/models.dart';
import 'package:modulife2/uikit/uicolors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.profile, required this.enableBackButton});

  final String title;
  final Profile? profile;
  final bool enableBackButton;

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
      automaticallyImplyLeading: enableBackButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}