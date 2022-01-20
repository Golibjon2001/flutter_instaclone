
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instaclone/post/user_post.dart';
import 'package:flutter_instaclone/servise/prefs_servise.dart';

class DataServise {
  static final _firestore = Firestore.instance;

  static String folder_users = "users";

  //User Related

  static Future storeUser(User user) async {
    user.uid = await Prefs.loadUserId();
    return _firestore.collection(folder_users).document(user.uid).setData(
        user.toJson());
  }

  static Future<User> loadUser() async {
    String uid = await Prefs.loadUserId();
    var value = await _firestore.collection('users').document(uid).get();
    User user = User.fromJson(value.data);
    return user;
  }

  static Future updateUser(User user) async {
    String uid = await Prefs.loadUserId();
    return _firestore.collection(folder_users).document(uid).updateData(
        user.toJson());
  }

  static Future<List<User>> searchUsers(String keyword) async {
    List<User> users = [];
    String uid = await Prefs.loadUserId();

    var querySnapshot = await _firestore.collection(folder_users).orderBy("email").startAt([keyword]).getDocuments();
    querySnapshot.documents.forEach((result) {
      User newUser = User.fromJson(result.data);
      if(newUser.uid!=uid){
        users.add(newUser);
      }
    });
    return users;
  }
}