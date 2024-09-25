part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class CreationNameChanged extends ProfileEvent {
  final String name;

  const CreationNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

final class CreationPronounsChanged extends ProfileEvent {
  final String pronouns;

  const CreationPronounsChanged(this.pronouns);

  @override
  List<Object> get props => [pronouns];
}

final class CreationAgeChanged extends ProfileEvent {
  final int age;

  const CreationAgeChanged(this.age);

  @override
  List<Object> get props => [age];
}

final class CreationAvatarChanged extends ProfileEvent {
  final String avatar;

  const CreationAvatarChanged(this.avatar);

  @override
  List<Object> get props => [avatar];
}

final class CreationSubmitted extends ProfileEvent {
  const CreationSubmitted();
}
