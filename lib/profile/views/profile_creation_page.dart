import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife2/profile/bloc/profile_bloc.dart';
import 'package:modulife2/profile/views/profile_creation_form.dart';
import 'package:modulife2/uikit/uicolors.dart';
import 'package:modulife2/widgets/custom_app_bar.dart';

class ProfileCreationPage extends StatelessWidget {
  const ProfileCreationPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfileCreationPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
          title: 'Profile creation', profile: null, enableBackButton: true),
      body: Container(
        color: UiColors.background,
        child: BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfileCreationForm()),
      ),
    );
  }
}
