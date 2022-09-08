import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel {
  final String email;
  final String name;
  final String cover;

  final String password;
  final String uid;
  final String image;
  final String bio;

  UserModel(
      {required this.email,
      required this.password,
      required this.uid,
      required this.image,
      required this.bio,
      required this.cover,
      required this.name});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'uid': uid});
    result.addAll({'image': image});
    result.addAll({'bio': bio});
  result.addAll({'cover': cover});
    result.addAll({'name': name});
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      cover: map['cover'] ?? '',
      image: map['image'] ?? '',
      password: map['password'] ?? '',
      uid: map['uid'] ?? '',
      bio: map['bio'] ?? '',
    );
  }
}
