import 'dart:developer';

import 'package:chat_app/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository with ChangeNotifier {
  final _fire = FirebaseFirestore.instance;
  String _chatRoomId = "";

  String get roomId => _chatRoomId;

  getChatRoom(UserM receiver) async {
    final shared = await SharedPreferences.getInstance();
    final uid = shared.getString('uid')!;
    if (uid.hashCode > receiver.uid.hashCode) {
      _chatRoomId = "${uid}_${receiver.uid}";
    } else {
      _chatRoomId = "${receiver.uid}_${uid}";
    }
  }

  Future<void> saveMessage(
      Map<String, dynamic> message, String chatRoomId) async {
    try {
      await _fire
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(message);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> userChatRooms() async {
    final shared = await SharedPreferences.getInstance();
    final uid = shared.getString('uid')!;
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fire
          .collection("chatRooms")
          .where('documentIdField',
              isEqualTo:
                  '24rGUVNbH7dxemZDv8EDwRo3rww2_QMnBQZG2tVMAgGCZmKi6S4N3WSF3')
          .get();

      log('usr : ${querySnapshot.size}');
      /* await _fire.collection("chatRooms").get().then((snapshot) {
        
        var roomId =
            snapshot.docs.where((doc) => doc.id.contains(uid)).toList();
        // Process the filtered documents

        log(roomId.toString());
      });*/

      //return res.docs.map((e) => UserM.fromMap(e.data())).toList();
    } catch (e) {
      rethrow;
    }
  }

  updateLastMessage(String currentUid, String receiverUid, String message,
      int timestamp) async {
    try {
      await _fire.collection("users").doc(currentUid).update({
        "lastMessage": {
          "content": message,
          "timestamp": timestamp,
          "senderId": currentUid
        },
        "unreadCounter": FieldValue.increment(1)
      });

      await _fire.collection("users").doc(receiverUid).update({
        "lastMessage": {
          "content": message,
          "timestamp": timestamp,
          "senderId": currentUid,
        },
        "unreadCounter": 0
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatRoomId) {
    return _fire
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
