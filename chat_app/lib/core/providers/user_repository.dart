import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserRepository with ChangeNotifier {
  final _fire = FirebaseFirestore.instance;

  UserM? _currentUser;
  UserM? get user => _currentUser;

  getUser() async {
    final userData = await loadUser();

    if (userData != null) {
      _currentUser = userData;
      notifyListeners();
    }
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString('uid', userData["uid"]);
    try {
      await _fire.collection("users").doc(userData["uid"]).set(userData);

      log("User saved successfully");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addRooms(String reId, String rooms) async {
    try {
      final userRoom = _currentUser!.rooms;
      final receiver = await _fire.collection("users").doc(reId).get();
      final rec = UserM.fromMap(receiver.data()!);
      final recRoom = rec.rooms;
      // log('userRoom isEmpty: ${userRoom!.isEmpty}');

      if (userRoom!.isNotEmpty && !userRoom.contains(rooms)) {
        userRoom.add(rooms);
      } else if (userRoom.isEmpty) {
        userRoom.add(rooms);
      }
      await _fire
          .collection("users")
          .doc(_currentUser!.uid)
          .update({"rooms": userRoom});

      if (recRoom!.isNotEmpty && !recRoom.contains(rooms)) {
        recRoom.add(rooms);
      } else if (recRoom.isEmpty) {
        recRoom.add(rooms);
      }
      await _fire.collection("users").doc(reId).update({"rooms": recRoom});

      log("User update room successfully");
    } catch (e) {
      rethrow;
    }
  }

  Future<UserM?> loadUser() async {
    final shared = await SharedPreferences.getInstance();
    final uid = shared.getString('uid')!;
    try {
      final res = await _fire.collection("users").doc(uid).get();

      if (res.data() != null) {
        log("User fetched successfully");
        return UserM.fromMap(res.data()!);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<UserM>> fetchUsers(String currentUserId) async {
    try {
      final res = await _fire
          .collection("users")
          .where("uid", isNotEqualTo: currentUserId)
          .get();

      return res.docs
          .map((e) => UserM.fromMap(e.data()))
          .toList(); //res.docs.map((e) => e.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserM>> searchUsers(String search) async {
    final shared = await SharedPreferences.getInstance();
    final uid = shared.getString('uid')!;
    search = search.toLowerCase();
    try {
      final res = await _fire
          .collection("users")
          .where("uid", isNotEqualTo: uid)
          .where(search.contains('@') ? "email" : "search",
              isGreaterThan: search)
          .orderBy('name')
          .get();

      return res.docs.map((e) => UserM.fromMap(e.data())).toList();
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
