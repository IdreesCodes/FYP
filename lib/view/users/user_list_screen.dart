import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              if (SessionController().userId.toString() ==
                  snapshot.child('uid')) {
                return Container();
              } else {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.child('profile').value.toString()),
                    ),
                    title: Text(snapshot.child('username').value.toString()),
                    subtitle: Text(snapshot.child('email').value.toString()),
                  ),
                );
              }
            }),
      ),
    );
  }
}
