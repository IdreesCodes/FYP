import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../../view_model/services/profile/profile_controller.dart';
import '../../view_model/services/session_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('Users');
    String? check = SessionController().userId;
    void initState() {
      // TODO: implement initState
      super.initState();
    }

    var username = '';

    return Scaffold(
        body: ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: StreamBuilder(
                  stream:
                      ref.child(SessionController().userId.toString()).onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      print(SessionController().userId.toString);
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      username = map['username'];
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                                child: Text(
                                  'Welcome back,',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 0.0,
                                ),
                                child: Text(
                                  '$username',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 47.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32.0),
                                      topRight: Radius.circular(32.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Your feed',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: 10,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                leading: const CircleAvatar(
                                                  backgroundColor: AppColors
                                                      .secondaryTextColor,
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                title: Text(
                                                  'Post $index',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: const Text(
                                                  'Lorem ipsum dolor sit amet',
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                          child: Text('Something Went Wrong',
                              style: Theme.of(context).textTheme.subtitle1));
                    }
                  },
                )),
          );
        },
      ),
    ));
  }
}
