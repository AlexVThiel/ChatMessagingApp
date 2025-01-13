import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserRepository with ChangeNotifier {
  final _fire = FirebaseFirestore.instance;

  Future<void> saveUser(Map<String, dynamic> userData) async {
    final shared = await SharedPreferences.getInstance(); //
    //shared.clear();
    shared.setString('uid', userData["uid"]);
    try {
      await _fire.collection("users").doc(userData["uid"]).set(userData);

      log("User saved successfully");
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> loadUser(String uid) async {
    try {
      final res = await _fire.collection("users").doc(uid).get();

      if (res.data() != null) {
        log("User fetched successfully");
        return res.data();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<UserModel>> fetchUsers(String currentUserId) async {
    try {
      final res = await _fire
          .collection("users")
          .where("uid", isNotEqualTo: currentUserId)
          .get();

      return res.docs
          .map((e) => UserModel.fromMap(e.data()))
          .toList(); //res.docs.map((e) => e.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> searchUsers(String search) async {
    final shared = await SharedPreferences.getInstance();
    final uid = shared.getString('uid')!;
    search = search.toLowerCase();
    log('search $search');

    try {
      final res = await _fire
          .collection("users")
          .where(Filter.and(
              Filter("uid", isNotEqualTo: uid),
              Filter(search.contains('@') ? "email" : "search",
                  isGreaterThanOrEqualTo: search)))
          .orderBy('name')

          /*search.contains('@') ? "email" : "search",
              isGreaterThan: search.toUpperCase())*/
          //.where('name', isGreaterThanOrEqualTo: search)
          // .where("search", isLessThanOrEqualTo: '$search\u{FFFF}')
          .get();

      return res.docs.map((e) => UserModel.fromMap(e.data())).toList();
      //return res.docs.map((e) => e.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserStream(
          String currentUserId) =>
      _fire
          .collection("users")
          .where("uid", isNotEqualTo: currentUserId)
          .snapshots();
}
