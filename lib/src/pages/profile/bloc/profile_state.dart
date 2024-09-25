part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  final FormzSubmissionStatus status;
  final Name name;
  final Pronouns pronouns;
  final Age age;
  //final Avatar avatar;
  final bool isValid;

  const ProfileState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const Name.pure(),
    this.pronouns = const Pronouns.pure(),
    this.age = const Age.pure(),
    this.isValid = false,
  });

  ProfileState copyWith({
    FormzSubmissionStatus? status,
    Name? name,
    Pronouns? pronouns,
    Age? age,
    bool? isValid,
  }) {
    return ProfileState(
      status: status ?? this.status,
      name: name ?? this.name,
      pronouns: pronouns ?? this.pronouns,
      age: age ?? this.age,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, name, pronouns, age];
}
