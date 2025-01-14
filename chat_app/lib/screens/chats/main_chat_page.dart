import 'package:chat_app/core/blocs/chat/chat_bloc.dart';
import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/core/providers/user_repository.dart';
import 'package:chat_app/screens/chats/new_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color.dart';
import '../../core/constants/icons.dart';
import '../../core/constants/styles.dart';
import '../../core/models/user.dart';
import '../../core/providers/chat_reposity.dart';

class MainChatPage extends StatefulWidget {
  const MainChatPage({super.key});

  static const routeName = '/mainChatPage';

  @override
  State<MainChatPage> createState() => _MainChatPageState();
}

class _MainChatPageState extends State<MainChatPage> {
  var allCaht = <Message>[];
  TextEditingController searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    /* ChatRepository chatRepository =
        Provider.of<ChatRepository>(context, listen: false);
    chatRepository
        .fetchWareHouseList()
        .then((value) => inventoryProvider.sortingInventory());
*/
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onRefresh(BuildContext context) async {
    setState(() {});
  }

  void _createNewRoom() async {
    Navigator.pushNamed(context, NewChatPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatBloc(
              RepositoryProvider.of<ChatRepository>(context),
            )..add(LoadAllChat()),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Chats", style: Constant.size14c476),
            backgroundColor: white,
            elevation: 2,
            actions: <Widget>[
              BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
                return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, NewChatPage.routeName);
                        // _createNewRoom();
                      },
                      child: startMess,
                    ));
              }),
            ],
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
                      child: TextField(
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
                          //filterSearchResults(value);
                        },
                        controller: searchController,
                      ),
                    ),
                    BlocListener<ChatBloc, ChatState>(
                      listener: (context, state) {
                        debugPrint(
                            '-----BlocListener state: ${state.runtimeType}');
                        if (state is ChatLodingState) {
                          //items.clear();
                          //allCaht.clear();
                        }

                        if (state is ChatLoadedState) {
                          //items.addAll(state.order.data);
                          //   allCaht.addAll(state.order.data);
                        }
                      },
                      child: BlocBuilder<ChatBloc, ChatState>(
                          builder: (context, state) {
                        if (state is ChatLodingState) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        }

                        if (state is ChatLoadedState) {
                          return Center(
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
                          // debugPrint(  '-----OrderLoadedState data ${state.order.data}');
                          /* return items.isNotEmpty
                              ? SizedBox(
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return OrderCard(
                                            data: items[index],
                                            action: _onConfirmTap);
                                        // Container();
                                      }),
                                )
                              : items.isEmpty && filter != ''
                                  ? const Expanded(
                          child: Center(
                            child: Text("No Users yet"),
                          ),
                        )
                                  : SizedBox(
                                      width: double.infinity,
                                      height: double.maxFinite,
                                      child: Column(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1.78,
                                            child: Image.asset(
                                              'assets/img_order.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              "ออเดอร์",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF474747),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            child: Text(
                                              "You don't have any order. Please create an order by click button below or button on the top right of screen",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: const Color(0XFF1A73F0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40, right: 40),
                                              child: BlocBuilder<OrderBloc,
                                                      OrderState>(
                                                  builder: (context, state) {
                                                return TextButton(
                                                    onPressed: () {
                                                      _onCreateTap(context);
                                                    },
                                                    child: const Text(
                                                      'สร้างออเดอร์',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ));
                                              }),
                                            ),
                                          )
                                        ],
                                      ),
                                    );*/
                        }

                        if (state is ChatErrorState) {
                          return SizedBox(
                            width: double.infinity,
                            height: double.maxFinite,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.78,
                                  child: Image.asset(
                                    'assets/img_order.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
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
                                          _onRefresh(context);
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
          ),
        ));
  }
}
