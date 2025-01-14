import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/providers/chat_reposity.dart';
import 'package:chat_app/core/providers/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/blocs/chat/chat_bloc.dart';
import '../../core/constants/color.dart';
import '../../core/constants/icons.dart';
import '../../core/constants/styles.dart';
import '../../core/models/message.dart';
import '../../core/widgets/bottom_field.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key, required this.receiver});
  static const routeName = '/chatRoomPage';
  final UserM receiver;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserRepository>(context).user;

    TextEditingController textController = TextEditingController();

    return BlocProvider(
      create: (context) => ChatBloc(
        RepositoryProvider.of<ChatRepository>(context),
      )..add(LoadAllChat()),
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text(receiver.name!, style: Constant.size14cW6),
          foregroundColor: white,
          backgroundColor: primary,
          elevation: 2,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: Constant.paddingSide10,
                child: Column(
                  children: [
                    Constant.sizedBoxH20,
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(0),
                        itemCount: 10, // model.messages.length,
                        separatorBuilder: (context, index) =>
                            Constant.sizedBoxH10,
                        itemBuilder: (context, index) {
                          final message = Message(
                            id: 'asdasdassad',
                            content: 'testttt',
                            senderId: 'erererere',
                            receiverId: 'erererere',
                            timestamp: DateTime.timestamp(),
                          );
                          // model.messages[index];
                          return ChatBubble(
                            isCurrentUser: message.senderId == currentUser!.uid,
                            message: message,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: greyOp12,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
              child: Row(
                children: [
                  InkWell(
                    onTap: null,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: white,
                      child: const Icon(
                        Icons.add,
                        color: black,
                      ),
                    ),
                  ),
                  Constant.sizedBoxW10,
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          contentPadding: Constant.paddingSide15,
                          filled: true,
                          fillColor: white,
                          hintStyle: Constant.size14cCC4,
                          suffixIcon: InkWell(onTap: () {}, child: send),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /* Row _buildHeader(BuildContext context, {String name = ""}) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: grey.withOpacity(0.15)),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        Constant.sizedBoxH15,
        Text(
          name,
          style: h.copyWith(fontSize: 20.sp),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: grey.withOpacity(0.15)),
          child: const Icon(Icons.more_vert),
        ),
      ],
    );
  }*/
}
