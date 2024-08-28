import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:modulife2/profile/bloc/profile_bloc.dart';
import 'package:modulife2/profile/models/models.dart';
import 'package:modulife2/uikit/uicolors.dart';

class ProfileCreationForm extends StatelessWidget {
  const ProfileCreationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (BuildContext context, ProfileState state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text('Profile creation failure')));
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            _AvatarUpload(),
            const SizedBox(height: 70),
            _NameInput(),
            _PronounsInput(),
            _AgeInput(),
            _CreateProfileButton(),
          ],
        ),
      ),
    );
  }
}

class _AvatarUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      key: Key('profileCreationForm_avatarUpload_circleAvatar'),
      radius: 73,
      backgroundColor: UiColors.accentColor1,
      child: CircleAvatar(
        radius: 70,
        backgroundColor: UiColors.accentColor2,
        child: Icon(
          Icons.upload,
          color: UiColors.accentColor1,
          size: 40,
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NameValidationError? displayError =
        context.select((ProfileBloc bloc) => bloc.state.name.displayError);

    return TextField(
      key: const Key('profileCreationForm_nameInput_textField'),
      onChanged: (String name) {
        context.read<ProfileBloc>().add(CreationNameChanged(name));
      },
      decoration: InputDecoration(
        labelText: 'Profile name',
        errorText: displayError != null ? 'Le nom ne doit pas être vide' : null,
      ),
    );
  }
}

class _PronounsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PronounsValidationError? displayError =
        context.select((ProfileBloc bloc) => bloc.state.pronouns.displayError);

    return TextField(
      key: const Key('profileCreationForm_pronounsInput_textField'),
      onChanged: (String pronouns) {
        context.read<ProfileBloc>().add(CreationPronounsChanged(pronouns));
      },
      decoration: InputDecoration(
        labelText: 'Profile pronouns',
        errorText: displayError != null
            ? 'Les pronons ne doivent pas être vide'
            : null,
      ),
    );
  }
}

class _AgeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AgeValidationError? displayError =
        context.select((ProfileBloc bloc) => bloc.state.age.displayError);

    return TextField(
      key: const Key('profileCreationForm_ageInput_textField'),
      onChanged: (String age) {
        context.read<ProfileBloc>().add(CreationAgeChanged(age as int));
      },
      decoration: InputDecoration(
        labelText: 'Profile age',
        errorText: displayError != null ? 'L\'âge ne doit pas être vide' : null,
      ),
    );
  }
}

class _CreateProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isInProgressOrSuccess = context
        .select((ProfileBloc bloc) => bloc.state.status.isInProgressOrSuccess);

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final bool isValid =
        context.select((ProfileBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
        key: const Key('profileCreationForm_continue_elevatedButton'),
        onPressed: isValid
            ? () => context.read<ProfileBloc>().add(const CreationSubmitted())
            : null,
        child: const Text('Create new profile'));
  }
}
