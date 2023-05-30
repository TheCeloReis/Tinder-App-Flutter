import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tinder_app_flutter/data/db/remote/response.dart';

class FirebaseStorageSource {
  FirebaseStorage instance = FirebaseStorage.instance;

  Future<Response<String>> uploadUserProfilePhoto(
      String filePath, String userId) async {
    String userPhotoPath = "user_photos/$userId/profile_photo";

    try {
      await instance.ref(userPhotoPath).putFile(File(filePath));
      String downloadUrl = await instance.ref(userPhotoPath).getDownloadURL();
      return Response.success(downloadUrl);
    } catch (e) {
      return Response.error(((e as FirebaseException).message ?? e.toString()));
    }
  }

  Future<List<Response<String>>> uploadPhotos(
      List<String> filePaths, String userId) async {
    List<Response<String>> uploadResults = [];

    for (int i = 0; i < filePaths.length; i++) {
      String userPhotoPath = "user_photos/$userId/photo_$i";

      try {
        await instance.ref(userPhotoPath).putFile(File(filePaths[i]));
        String downloadUrl = await instance.ref(userPhotoPath).getDownloadURL();
        uploadResults.add(Response.success(downloadUrl));
      } catch (e) {
        uploadResults.add(
            Response.error(((e as FirebaseException).message ?? e.toString())));
      }
    }

    return uploadResults;
  }
}
