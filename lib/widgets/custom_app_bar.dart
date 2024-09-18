import 'package:flutter/material.dart';

import 'package:modulife/profile/models/models.dart';
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
        PopupMenuButton<int>(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          offset: const Offset(0, 43),
          onSelected: (int result){
            if (result == 0) {
              // TODO: Implement the settings page navigation here
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<int>(
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Settings'),
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
