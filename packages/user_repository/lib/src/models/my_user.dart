import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/my_user_entite.dart';

class MyUserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;
  final String? bio;

  const MyUserModel({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    this.bio,
  });

  // Empty user which represent unauthenticated user
  static const empty = MyUserModel(
    id: '',
    email: '',
    name: '',
    picture: '',
    bio: '',
  );

  MyUserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
    String? bio,
  }) {
    return MyUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.email,
      picture: picture ?? this.picture,
      bio: bio ?? this.bio,
    );
  }

  // Getter to verify if the user is empty
  bool get isEmpty => this == MyUserModel.empty;

  // Getter to verify if the user is not empty
  bool get isNotEmpty => this != MyUserModel.empty;

  MyUserEntite toEntity() {
    return MyUserEntite(
      id: id,
      email: email,
      name: name,
      picture: picture,
      bio: bio,
    );
  }

  static MyUserModel fromEntity(MyUserEntite entity) {
    return MyUserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
      bio: entity.bio,
    );
  }

  @override
  List<Object?> get props => [email, name, id, picture, bio];
}
