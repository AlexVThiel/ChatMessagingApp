import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color.dart';

class MainProfilePage extends StatelessWidget {
  const MainProfilePage({super.key});
  static const routeName = '/mainProfilePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile", style: Constant.size14c476),
          backgroundColor: white,
          elevation: 2,
        ),
        body: Placeholder());
  }
}
