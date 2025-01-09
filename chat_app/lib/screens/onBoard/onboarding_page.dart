import 'package:flutter/material.dart';
import '../login_page.dart';
import '../../main.dart';
import '../../screens/onBoard/onboard_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  static const routeName = '/onBoard';
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void goToLogin() {
    Navigator.of(context).pushNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
          child: PageView(
            controller: controller,
            onPageChanged: (index) => {setState(() => isLastPage = index == 3)},
            children: const [
              OnBoardView(
                  urlImage: 'assets/onboard1.jpg',
                  title: 'Chat App',
                  detail: "Testing Chat App"),
              OnBoardView(
                  urlImage: 'assets/onboard2.jpg',
                  title: 'Swip to next Page',
                  detail:
                      "Testing this detail app text on on-boarding in 2 page"),
              OnBoardView(
                  urlImage: 'assets/onboard3.jpg',
                  title: 'Swip to next Page',
                  detail:
                      "Testing this detail app text on on-boarding in 3 page"),
              OnBoardView(
                  urlImage: 'assets/onboard4.jpg',
                  title: 'สรุปผลช่วยในการตัดสินใจ',
                  detail:
                      "Testing this detail app text on on-boarding in last page"),
            ],
          ),
        ),
        Positioned(
          top: 55,
          right: 20,
          child: TextButton(
            onPressed: () => controller.jumpToPage(3),
            child: const Text(
              'ข้าม',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 12,
                  color: Color.fromARGB(255, 162, 176, 204)),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 245),
            child: SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: const JumpingDotEffect(
                dotColor: Color(0xFFD9D9D9),
                activeDotColor: Color(0xFF236BBD),
                dotHeight: 10,
                dotWidth: 10,
              ),
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeIn),
            ),
          ),
        ),
        isLastPage
            ? Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 40),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0XFF236BBD),
                    ),
                    child: TextButton(
                        onPressed: () async {
                          await SharedPreferences.getInstance().then((value) {
                            value.setBool('firstOpen', false);
                            goToLogin();
                            //Navigator.pushNamed(context, LoginPage.routeName);
                            // Navigator.pushNamed(context, '/loginPage');
                          });
                        },
                        child: const Text(
                          'ลงชื่อเข้าสู่ระบบ',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              )
            : const SizedBox(
                height: 1,
              )
      ]),
    );
  }
}
