import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/color.dart';
import '../constants/styles.dart';
import '../models/message.dart';
import 'textfield_widget.dart';

class BottomField extends StatelessWidget {
  const BottomField({super.key, this.onTap, this.onChanged, this.controller});
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyOp12,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
      child: Row(
        children: [
          InkWell(
            onTap: null,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: white,
              child: const Icon(Icons.add),
            ),
          ),
          Constant.sizedBoxW10,
          Expanded(
              child: CustomTextfield(
            controller: controller,
            isChatText: true,
            hintText: "Write message..",
            onChanged: onChanged,
            onTap: onTap,
          ))
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, this.isCurrentUser = true, required this.message});
  final bool isCurrentUser;
  final Message message;

  @override
  Widget build(BuildContext context) {
    final borderRadius = isCurrentUser
        ? BorderRadius.only(
            topLeft: Constant.r16,
            topRight: Constant.r16,
            bottomLeft: Constant.r16)
        : BorderRadius.only(
            topLeft: Constant.r16,
            topRight: Constant.r16,
            bottomRight: Constant.r16);
    final alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: double.maxFinite * 0.75, minWidth: 50),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isCurrentUser ? primary : greyOp12,
            borderRadius: borderRadius),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              message.content!,
              style: isCurrentUser ? Constant.size14cW4 : null,
            ),
            Constant.sizedBoxH5,
            Text(
              DateFormat('hh:mm a').format(message.timestamp!),
              style: isCurrentUser ? Constant.size10cW4 : null,
            )
          ],
        ),
      ),
    );
  }
}
