import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kuponberhadiah/view/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 4),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic>route) => false),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.1, end: 1.5),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOutBack,
              builder: (BuildContext context, dynamic value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/splash.png",
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const Text("Kupon Berhadiah App",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,
                        fontSize: 12.0, fontFamily: "poppins", )
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
