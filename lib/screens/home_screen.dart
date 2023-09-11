import 'dart:convert';
import 'dart:developer';
import 'package:chat_verse/api/apis.dart';
import 'package:chat_verse/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import '../models/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
          leading: const Icon(CupertinoIcons.home),
          title: const Text("ChatVerse"),
          actions: [
            //search user button
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

            //more user button
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ]),

      //floating button to add new users
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () async {
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            },
            child: const Icon(Icons.add_comment_rounded)),
      ),

      //body
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            //if sme or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(top: mq.height * .01),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUserCard(user: list[index]);
                      //return Text('Name: ${list[index]}');
                    });
              } else {
                return const Center(
                  child: Text('No Connections Found!',
                      style: TextStyle(fontSize: 20)),
                );
              }
          }
        },
      ),
    );
  }
}
