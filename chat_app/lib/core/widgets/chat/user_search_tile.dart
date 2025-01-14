import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../models/user.dart';

class UserSearchTile extends StatelessWidget {
  const UserSearchTile({super.key, this.onTap, required this.user});
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
    );
  }
}
