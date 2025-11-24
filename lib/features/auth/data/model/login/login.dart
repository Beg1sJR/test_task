// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String? token;
  final UserModel? user;
  const LoginModel({this.token, this.user});

  LoginModel copyWith({String? token, UserModel? user}) {
    return LoginModel(token: token ?? this.token, user: user ?? this.user);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'token': token, 'user': user?.toMap()};
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      token: map['token'] != null ? map['token'] as String : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, user];
}

class UserModel extends Equatable {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  const UserModel({this.id, this.email, this.firstName, this.lastName});

  UserModel copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, email, firstName, lastName];
}
