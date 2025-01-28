import 'dart:developer';

import 'package:chat_app/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/message.dart';

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

  Future<List> userChatRooms() async {
    final shared = await SharedPreferences.getInstance();
    final uid = shared.getString('uid')!;
    final rooms =
        await _fire.collection("users").doc(uid).get().then((receiver) {
      final rec = UserM.fromMap(receiver.data()!);
      final recRoom = rec.rooms;
      var r = [];
      for (var rid in recRoom!) {
        final revid = (rid as String).replaceAll(uid, "").replaceAll("_", "");
        final res =
            _fire.collection("users").where("uid", isEqualTo: revid).get();
        r.add(revid);
      }
      return r;
      /* try {
        for (var rid in recRoom!) {
          //  final Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
         final mess = _fire
              .collection("chatRooms")
              .doc(rid)
              .collection("messages")
              .orderBy("timestamp", descending: false)
              .get();
          final revid =
                (rid as String).replaceAll(uid, "").replaceAll("_", "");
                final list =
                mess.docs.map((e) => Message.fromMap(e.data())).toList();

              .listen((messages) {
            final revid =
                (rid as String).replaceAll(uid, "").replaceAll("_", "");
            final list =
                messages.docs.map((e) => Message.fromMap(e.data())).toList();
           // r.add({revid, list});
            return {revid, list};
            // .addAll({revid, list} as Map);
            //.add(
            // messages.docs.map((e) => Message.fromMap(e.data())).toList());
            //log('rooms.size : ${rooms.length}');
          });
        }

        //  log('r.length : ${r[0].toString()}');
        return r;
      } catch (e) {
        rethrow;
      }*/
    });
    var u = [];
    for (var rid in rooms!) {
      final revid = (rid as String).replaceAll(uid, "").replaceAll("_", "");
      final res =
          await _fire.collection("users").where("uid", isEqualTo: revid).get();
      u.add(UserM.fromMap(res.docs[0].data()));
    }

    log('u.length : ${u.length}');
    // log('rooms.length : ${rooms.length}');
    return u;
  }

  Future<UserM> getUsers(String recId) async {
    try {
      final res =
          await _fire.collection("users").where("uid", isEqualTo: recId).get();

      return UserM.fromMap(res.docs[0].data());
      /*  res.docs[0]
          .data()
          .map((e) => UserM.fromMap(e.data()))
          .toList(); //res.docs.map((e) => e.data()).toList();*/
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
