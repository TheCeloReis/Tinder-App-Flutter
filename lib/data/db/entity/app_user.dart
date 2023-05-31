import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser {
  String id;
  String name;
  int age;
  String profilePhotoPath;
  List<String> photosPath = [];
  String bio = "";

  String typingTo;
  int typingAt;
  int priority;

  AppUser(
      {@required this.id,
      @required this.name,
      @required this.age,
      @required this.profilePhotoPath,
      @required this.photosPath,
      this.priority = 1});

  AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    age = snapshot['age'];
    profilePhotoPath = snapshot['profile_photo_path'];
    photosPath = snapshot['photos_path'].cast<String>();
    bio = snapshot.get('bio') ?? '';
    typingTo = snapshot.get('typing_to') ?? '';
    typingAt = snapshot.get('typing_at') ?? 0;
    priority = snapshot.get('priority') ?? 1;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'profile_photo_path': profilePhotoPath,
      'photos_path': photosPath,
      'bio': bio,
      'typing_to': typingTo,
      'typing_at': typingAt,
      'priority': priority,
    };
  }
}
