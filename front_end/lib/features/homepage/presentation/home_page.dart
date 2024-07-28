import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genix_auctions/core/shared_preference.dart';
import 'package:genix_auctions/features/homepage/components/grid.dart';
import 'package:genix_auctions/features/homepage/components/navi_bar.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 10;
  int data = 0;
  var user;

  final ItemsProvider _itemsProvider = ItemsProvider();
  Stream<List<dynamic>>? itemsStream;

  getUserDetails() async {
    await getUserCredentials().then((val) {
      setState(() {
        user = val;
      });
    });
    // print(user);
  }

  @override
  void initState() {
    super.initState();
    itemsStream = _itemsProvider.fetchItemsStream();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 70,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Image(
                                image:
                                    AssetImage("./assets/images/home_pic.png")),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 190, vertical: 105),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Your Gateway \nto Extraordinary \nFinds",
                              style: TextStyle(
                                fontSize: 53,
                              ),
                            ),
                            const Text(
                              "Unlock deals, bid smart, and seize the moment \nWith our online bidding bonanza!",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: InkWell(
                                onTap: () async {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color.fromARGB(255, 87, 71, 255),
                                          Color.fromARGB(255, 93, 185, 255),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: const SizedBox(
                                      width: 170,
                                      height: 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.play_circle_outline_rounded,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Watch Video",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Outfit",
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 190),
                  child: Row(
                    children: [
                      Text(
                        "Explore ",
                        style: TextStyle(
                          fontFamily: "Outfit-Bold",
                          fontSize: 27,
                        ),
                      ),
                      Text(
                        "Auctions",
                        style: TextStyle(
                          fontFamily: "Outfit-Bold",
                          fontSize: 27,
                          color: Color.fromARGB(255, 25, 21, 244),
                        ),
                      ),
                    ],
                  ),
                ),
                ResponsiveGridView(
                  itemsStream: itemsStream,
                  count: count,
                ),
                count > data
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              count = count + 10;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color.fromARGB(255, 87, 71, 255),
                                  Color.fromARGB(255, 80, 179, 255),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: Text(
                                "Load more...",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: "Outfit",
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  child: Container(
                    height: 300,
                    color: const Color.fromARGB(255, 12, 0, 54),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Image(
                                      image: AssetImage("assets/logo.png"),
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Text(
                                    "Genix Auctions",
                                    style: TextStyle(
                                      fontFamily: "Outfit",
                                      fontSize: 21,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Products",
                                    style: TextStyle(
                                      fontFamily: "Outfit",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    "About Us",
                                    style: TextStyle(
                                      fontFamily: "Outfit",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    "Contact",
                                    style: TextStyle(
                                      fontFamily: "Outfit",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Auctions",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Bidding",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.64,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.copyright_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(
                                "  Copyright 2024, All Rights Reserved by Genix",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyNavigationBar(user: user!['userId']),
          ),
        ],
      ),
    );
  }
}

class ItemsProvider {
  Stream<List<dynamic>> fetchItemsStream() async* {
    while (true) {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/v1/items'),
      );

      if (response.statusCode == 200) {
        yield jsonDecode(response.body);
      } else {
        throw Exception('Failed to load items');
      }

      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
