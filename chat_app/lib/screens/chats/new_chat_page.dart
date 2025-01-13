import 'package:chat_app/core/blocs/user/user_bloc.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/providers/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color.dart';
import '../../core/constants/icons.dart';
import '../../core/constants/styles.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  static const routeName = '/newChatPage';

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  TextEditingController searchController = TextEditingController();
  var allUsers = <UserModel>[];
  var items = <UserModel>[];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterSearchResults(String query) {
    /* List<UserModel> dummySearchList = <UserModel>[];
    dummySearchList.addAll(allUsers);
    if (query.isNotEmpty) {
      List<UserModel> dummyListData = <UserModel>[];
      for (var item in dummySearchList) {
        dummyListData.add(item);
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(allUsers);
      });
    }*/
    context.read<UserBloc>().add(SearchUsers(query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      ),
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
                    BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        debugPrint(
                            '-----BlocListener state: ${state.runtimeType}');
                        if (state is UsersLodingState) {
                          //items.clear();
                          //allCaht.clear();
                        }

                        if (state is UsersLoadedState) {
                          //items.addAll(state.order.data);
                          //   allCaht.addAll(state.order.data);
                          print(state.usersList.toString());
                        }
                      },
                      child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                        /*  if (state is UsersLodingState) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        }*/

                        if (state is UsersLoadedState) {
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

                        if (state is UsersErrorState) {
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
