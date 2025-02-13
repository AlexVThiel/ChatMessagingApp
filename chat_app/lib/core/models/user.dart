import 'dart:convert';
import 'dart:developer';

class UserM {
  final String? uid;
  final String? name;
  final String? email;
  final String? imageUrl;
  final Map<String, dynamic>? lastMessage;
  final int? unreadCounter;
  final List<dynamic>? rooms;

  UserM(
      {this.uid,
      this.name,
      this.email,
      this.imageUrl,
      this.lastMessage,
      this.unreadCounter,
      this.rooms});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'unreadCounter': unreadCounter,
      'rooms': rooms
    };
  }

  factory UserM.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return UserM(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      lastMessage: map['lastMessage'] != null
          ? Map<String, dynamic>.from(
              map['lastMessage'] as Map<String, dynamic>)
          : null,
      unreadCounter:
          map['unreadCounter'] != null ? map['unreadCounter'] as int : null,
      rooms: map['rooms'] != null ? map['rooms'] as List<dynamic> : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserM.fromJson(String source) =>
      UserM.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, imageUrl: $imageUrl, lastMessage: $lastMessage, unreadCounter: $unreadCounter, rooms: $rooms)';
  }
}
