import 'package:chat_app/core/blocs/user/user_bloc.dart';
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
import '../../core/widgets/chat/user_search_tile.dart';
import 'chat_room_page.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  static const routeName = '/newChatPage';

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  TextEditingController searchController = TextEditingController();
  var usersList = <UserM>[];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void setNewChatRoom(UserM u, BuildContext ct) async {
    final currentUser =
        Provider.of<UserRepository>(context, listen: false).user!;
    var chatRoomId = "";

    if (currentUser.uid.hashCode > u.uid.hashCode) {
      chatRoomId = "${currentUser.uid}_${u.uid}";
    } else {
      chatRoomId = "${u.uid}_${currentUser.uid}";
    }
    Provider.of<UserRepository>(context, listen: false)
        .addRooms(u.uid!, chatRoomId);

    final now = DateTime.now();

    final message = Message(
        id: now.millisecondsSinceEpoch.toString(),
        content: '',
        senderId: currentUser.uid,
        receiverId: u.uid,
        timestamp: now);

    ct.read<ChatBloc>().add(SaveChat(message.toMap(), chatRoomId));
    Navigator.pushReplacementNamed(context, ChatRoomPage.routeName,
        arguments: u);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserBloc(
                  RepositoryProvider.of<UserRepository>(context),
                )),
        BlocProvider(
            create: (context) => ChatBloc(
                  RepositoryProvider.of<ChatRepository>(context),
                )),
      ],
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("New Message", style: Constant.size14c476),
            backgroundColor: white,
            elevation: 2,
          ),
          body: Container(
            color: bgColor,
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Padding(
                padding: Constant.paddingTopSide,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                        return TextField(
                          decoration: InputDecoration(
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white,
                            suffixIcon: const Icon(Icons.search),
                            suffixIconColor: Colors.grey.shade500,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                                borderRadius: Constant.borderRd10),
                            labelText: 'Search',
                            labelStyle: Constant.size14c474,
                          ),
                          onChanged: (value) {
                            context.read<UserBloc>().add(SearchUsers(value));
                            // filterSearchResults(value);
                          },
                          controller: searchController,
                        );
                      }),
                    ),
                    Constant.sizedBoxH10,
                    BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        debugPrint(
                            '-----BlocListener state: ${state.runtimeType}');
                        if (state is LodingState) {
                          usersList.clear();
                        }

                        if (state is UsersLoadedState) {
                          usersList.addAll(state.usersList);
                        }
                      },
                      child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                        if (state is LodingState) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        }

                        if (state is UsersLoadedState) {
                          return usersList.isNotEmpty
                              ? BlocBuilder<ChatBloc, ChatState>(
                                  builder: (ctx, state) {
                                  return SizedBox(
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: usersList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return UserSearchTile(
                                            user: usersList[index],
                                            onTap: () => setNewChatRoom(
                                                usersList[index], ctx),
                                          );
                                        }),
                                  );
                                })
                              : Center(
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        /* AspectRatio(
                                                aspectRatio: 1.78,
                                                child: Image.asset(
                                                  'assets/img_order.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),*/
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            "You don\'t have any message",
                                            style: Constant.size14cB6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }

                        if (state is ErrorState) {
                          return SizedBox(
                            width: double.infinity,
                            height: double.maxFinite,
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Sorry!",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF474747),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 15),
                                  child: Text(
                                    'Somthing went wrong. Please try again',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0XFF1A73F0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: TextButton(
                                        onPressed: () {
                                          // _onRefresh(context);
                                        },
                                        child: const Text(
                                          'Refresh',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Container();
                      }),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
