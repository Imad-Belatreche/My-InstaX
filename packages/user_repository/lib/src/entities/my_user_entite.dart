import 'package:equatable/equatable.dart';

class MyUserEntite extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;
  final String? bio;

  const MyUserEntite({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    this.bio,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'picture': picture,
      'bio': bio,
    };
  }

  static MyUserEntite fromDocument(Map<String, dynamic> doc) {
    return MyUserEntite(
      id: doc['id'],
      email: doc['email'],
      name: doc['name'],
      picture: doc['picture'],
      bio: doc['bio'],
    );
  }

  @override
  String toString() {
    return '''UserEntity: {
      id: $id,
      email: $email,
      name: $name,
      picture: $picture,
      bio: $bio,
      }''';
  }

  @override
  List<Object?> get props => [id, email, name, picture, bio];
}
