import 'package:flutter/material.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({
    Key? key,
    required this.urlImage,
    required this.title,
    required this.detail,
  }) : super(key: key);

  final String urlImage;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            height: 250,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(title,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 66, 67, 75),
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              detail,
              style: const TextStyle(
                color: Color.fromARGB(255, 173, 173, 173),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
