import 'package:flutter/material.dart';

class Story extends StatefulWidget {
  const Story({Key? key}) : super(key: key);

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)]),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.5),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
