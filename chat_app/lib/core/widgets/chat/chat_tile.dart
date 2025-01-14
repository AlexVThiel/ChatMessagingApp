import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../models/user.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, this.onTap, required this.user});
  final UserM user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.grey.shade200,
      contentPadding: Constant.paddingSide10,
      shape: RoundedRectangleBorder(borderRadius: Constant.borderRd15),
      leading: user.imageUrl == null
          ? CircleAvatar(
              backgroundColor: grey.withOpacity(0.5),
              radius: 25,
              child: Text(
                user.name![0],
                style: Constant.size14cB6,
              ),
            )
          : ClipOval(
              child: Image.network(
                user.imageUrl!,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
      title: Text(user.name!),
      subtitle: Text(
        user.lastMessage != null ? user.lastMessage!["content"] : "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            user.lastMessage == null ? "" : getTime(),
            style: const TextStyle(color: grey),
          ),
          Constant.sizedBoxH10,
          user.unreadCounter == 0 || user.unreadCounter == null
              ? Constant.sizedBoxH15
              : CircleAvatar(
                  radius: 8,
                  backgroundColor: primary,
                  child: Text(
                    "${user.unreadCounter}",
                    style: Constant.size14cB4,
                  ),
                )
        ],
      ),
    );
  }

  String getTime() {
    DateTime now = DateTime.now();

    DateTime lastMessageTime = user.lastMessage == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(user.lastMessage!["timestamp"]);

    int minutes = now.difference(lastMessageTime).inMinutes % 60;

    if (minutes < 60) {
      return "$minutes minutes ago";
    } else {
      return "${now.difference(lastMessageTime).inHours % 24} hours ago";
    }
  }
}
