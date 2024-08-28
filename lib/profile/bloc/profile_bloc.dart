import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:modulife2/profile/models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<CreationNameChanged>(_creationNameChanged);
    on<CreationPronounsChanged>(_creationPronounsChanged);
    on<CreationAgeChanged>(_creationAgeChanged);
    on<CreationSubmitted>(_creationSubmitted);
  }

  void _creationNameChanged(
      CreationNameChanged event, Emitter<ProfileState> emit) {
    final Name name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.pronouns, state.age]),
      ),
    );
  }

  void _creationPronounsChanged(
      CreationPronounsChanged event, Emitter<ProfileState> emit) {
    final Pronouns pronouns = Pronouns.dirty(event.pronouns);
    emit(
      state.copyWith(
        pronouns: pronouns,
        isValid: Formz.validate([state.name, pronouns, state.age]),
      ),
    );
  }

  void _creationAgeChanged(
      CreationAgeChanged event, Emitter<ProfileState> emit) {
    final Age age = Age.dirty(event.age as String);
    emit(
      state.copyWith(
        age: age,
        isValid: Formz.validate([state.name, state.pronouns, age]),
      ),
    );
  }

  Future<void> _creationSubmitted(
      CreationSubmitted event, Emitter<ProfileState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
