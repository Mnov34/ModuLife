import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife/profile/bloc/profile_bloc.dart';
import 'package:modulife/profile/views/profile_creation_form.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';
import 'package:modulife/widgets/custom_app_bar.dart';

class ProfileCreationPage extends StatelessWidget {
  const ProfileCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
          title: 'Profile creation', profile: null, isBackButtonEnabled: true),
      body: Container(
        color: UiColors.background,
        child: BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfileCreationForm()),
      ),
    );
  }
}
