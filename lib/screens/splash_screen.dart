import 'dart:developer';
import 'package:chat_verse/api/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

// splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      if (APIs.auth.currentUser != null) {
        log('\nUser: ${APIs.auth.currentUser}');
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      // //app bar
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text("Welcome to ChatVerse"),
      // ),
      backgroundColor: Color.fromARGB(95, 12, 14, 154),
      //body
      body: Stack(children: [
        //app logo
        Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/ChatVerse_icon.png')),

        Positioned(
            bottom: mq.height * .35,
            width: mq.width * 1,
            child: const Text(
              'ChatVerse',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30,color: Colors.white),
            )),
        Positioned(
            bottom: mq.height * .3,
            width: mq.width * 1,
            child: const Text(
              'Explore. Engage. Evolve',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.white70),
            )),
        Positioned(
            bottom: mq.height * .04,
            width: mq.width * 1,
            child: const Text(
              'Copyright © 2023 Shrestha Narayan Sinha.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, color: Colors.grey),
            )),
        Positioned(
            bottom: mq.height * 0.01,
            width: mq.width * 1,
            child: const Text(
              'All rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.white24),
            )),
      ]),
    );
  }
}
