import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile(this.id, this.name, this.pronouns, this.age, this.avatar);

  final int? id;
  final String name;
  final String pronouns;
  final int age;
  final String avatar;

  @override
  List<Object> get props => [name, pronouns, age, avatar];

  static const Profile empty = Profile (null,'-', '-', 0, '-');
}