import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/data/db/entity/chat.dart';
import 'package:tinder_app_flutter/data/db/remote/firebase_auth_source.dart';
import 'package:tinder_app_flutter/data/db/remote/firebase_database_source.dart';
import 'package:tinder_app_flutter/data/db/remote/firebase_storage_source.dart';
import 'package:tinder_app_flutter/data/db/remote/response.dart';
import 'package:tinder_app_flutter/data/model/chat_with_user.dart';
import 'package:tinder_app_flutter/data/model/user_registration.dart';
import 'package:tinder_app_flutter/util/shared_preferences_utils.dart';
import 'package:tinder_app_flutter/data/db/entity/app_user.dart';
import 'package:tinder_app_flutter/util/utils.dart';
import 'package:tinder_app_flutter/data/db/entity/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  FirebaseAuthSource _authSource = FirebaseAuthSource();
  FirebaseStorageSource _storageSource = FirebaseStorageSource();
  FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();

  bool isLoading = false;
  AppUser _user;

  Future<AppUser> get user => _getUser();

  Future<Response> loginUser(String email, String password,
      GlobalKey<ScaffoldState> errorScaffoldKey) async {
    Response<dynamic> response = await _authSource.signIn(email, password);
    if (response is Success<UserCredential>) {
      String id = response.value.user.uid;
      SharedPreferencesUtil.setUserId(id);
    } else if (response is Error) {
      showSnackBar(errorScaffoldKey, response.message);
    }
    return response;
  }

  Future<Response> registerUser(UserRegistration userRegistration,
      GlobalKey<ScaffoldState> errorScaffoldKey) async {
    Response<dynamic> authResponse = await _authSource.register(
        userRegistration.email, userRegistration.password);
    if (authResponse is Success<UserCredential>) {
      String userId = authResponse.value.user.uid;

      Response<dynamic> profilePhotoResponse =
          await _storageSource.uploadUserProfilePhoto(
              userRegistration.localProfilePhotoPath, userId);

      // await _storageSource.uploadPhotos(userRegistration.localPhotosPath, userId);
      List<Response<dynamic>> photosResponse = await _storageSource
          .uploadPhotos(userRegistration.localPhotosPath, userId);

      if (profilePhotoResponse is Success<String>) {
        String profilePhotoUrl = profilePhotoResponse.value;
        AppUser user = AppUser(
          id: userId,
          name: userRegistration.name,
          age: userRegistration.age,
          profilePhotoPath: profilePhotoUrl,
          photosPath: photosResponse
              .where((response) => response is Success<String>)
              .map((response) => (response as Success<String>).value)
              .toList(),
        );
        _databaseSource.addUser(user);
        SharedPreferencesUtil.setUserId(userId);
        _user = _user;
        return Response.success(user);
      }
    }
    if (authResponse is Error) {
      showSnackBar(errorScaffoldKey, authResponse.message);
    }
    return authResponse;
  }

  Future<AppUser> _getUser() async {
    if (_user != null) return _user;
    String id = await SharedPreferencesUtil.getUserId();
    if (id == null || id.isEmpty) {
      await logoutUser();
      return null;
    }
    DocumentSnapshot userSnapshot = await _databaseSource.getUser(id);
    if (userSnapshot.exists) {
      _user = AppUser.fromSnapshot(userSnapshot);
      return _user;
    } else {
      await logoutUser();
      return null;
    }
  }

  void updateUserProfilePhoto(
      String localFilePath, GlobalKey<ScaffoldState> errorScaffoldKey) async {
    isLoading = true;
    notifyListeners();
    Response<dynamic> response =
        await _storageSource.uploadUserProfilePhoto(localFilePath, _user.id);
    isLoading = false;
    if (response is Success<String>) {
      _user.profilePhotoPath = response.value;
      _databaseSource.updateUser(_user);
    } else if (response is Error) {
      showSnackBar(errorScaffoldKey, response.message);
    }
    notifyListeners();
  }

  void updateUserBio(String newBio) {
    _user.bio = newBio;
    _databaseSource.updateUser(_user);
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _user = null;
    await SharedPreferencesUtil.removeUserId();
  }

  Future<List<ChatWithUser>> getChatsWithUser(String userId) async {
    var matches = await _databaseSource.getMatches(userId);
    List<ChatWithUser> chatWithUserList = [];

    for (var i = 0; i < matches.size; i++) {
      Match match = Match.fromSnapshot(matches.docs[i]);
      AppUser matchedUser =
          AppUser.fromSnapshot(await _databaseSource.getUser(match.id));

      String chatId = compareAndCombineIds(match.id, userId);

      Chat chat = Chat.fromSnapshot(await _databaseSource.getChat(chatId));
      ChatWithUser chatWithUser = ChatWithUser(chat, matchedUser);
      chatWithUserList.add(chatWithUser);
    }
    return chatWithUserList;
  }
}
