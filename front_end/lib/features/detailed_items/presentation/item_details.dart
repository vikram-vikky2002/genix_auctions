import 'dart:async';
import 'dart:convert';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:genix_auctions/core/shared_preference.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.itemId});

  final String itemId;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  Future<Map>? fetchItemFuture;
  TextEditingController bidController = TextEditingController();
  Timer? timer;
  Duration remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    fetchItemFuture = fetchItemById(widget.itemId);
  }

  Future<Map> fetchItemById(String id) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/v1/items/$id'),
    );

    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      final endTime = DateTime.parse(item['endDate']);
      setRemainingTime(endTime);
      return item;
    } else {
      throw Exception('Failed to load item');
    }
  }

  void setRemainingTime(DateTime endTime) {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final remaining = endTime.difference(now);

      if (remaining.isNegative) {
        timer.cancel();
        setState(() {
          remainingTime = Duration.zero;
        });
      } else {
        setState(() {
          remainingTime = remaining;
        });
      }
    });
  }

  updateBid(String itemId, String name, String bidValue) async {
    final url = 'http://localhost:3000/api/v1/items/$itemId/bid';
    await getUserCredentials().then((val) async {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'bidValue': bidValue,
          "date": DateTime.now().toIso8601String(),
          "userEmail": val['userId'],
        }),
      );

      if (response.statusCode == 200) {
        setState(() {});
        context.pop();
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit bid');
      }
    });
  }

  void show(String name, int currentBid, String endTime) {
    final end = DateTime.parse(endTime);
    final timeDef = end.difference(DateTime.now());
    showDialog(
      barrierColor: const Color.fromARGB(0, 255, 255, 255),
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 480, vertical: 190),
            child: BlurryContainer(
              color: const Color.fromARGB(115, 255, 255, 255),
              blur: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Submit Bid | ',
                                  style: TextStyle(
                                    fontFamily: 'Outfit-Bold',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 17,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Ends in : ${timeDef.inDays} days ${(timeDef.inHours) % 24} hours ${(timeDef.inMinutes) % 60} mins',
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () => context.pop(),
                          child: const Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Current bid : ',
                              style: TextStyle(
                                fontFamily: 'Outfit-Bold',
                              ),
                            ),
                            Text(
                              '\$ $currentBid',
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 50,
                    ),
                    child: TextFormField(
                      controller: bidController,
                      decoration: const InputDecoration(
                        labelText: 'Straight bid',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () =>
                        updateBid(widget.itemId, name, bidController.text),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 45, 55, 255),
                        Color.fromARGB(255, 97, 184, 255)
                      ])),
                      width: 130,
                      height: 50,
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bid Now',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Outfit'),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map>(
        future: fetchItemFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final item = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Hero(
                      tag: 'ProductImage${widget.itemId}',
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.blue,
                            Colors.redAccent,
                          ]),
                        ),
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 230),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 20,
                          color: item['status'] == 'active'
                              ? Colors.green
                              : Colors.red,
                          child: Center(
                            child: Text(
                              item['status'] == 'active'
                                  ? "Active"
                                  : "Inactive",
                              style: TextStyle(
                                  color: item['status'] == 'active'
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: 'Outfit'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '${item['name']}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: "Outfit-Bold",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${item['description']}',
                    style: const TextStyle(
                      fontFamily: "Outfit",
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 230),
                    child: Row(
                      children: [
                        Text(
                          'Minimum Bid: \$${item['minimumBid']}',
                          style: const TextStyle(
                            fontFamily: "Outfit",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 230),
                    child: Row(
                      children: [
                        Text(
                          'Current Bid: \$${item['currentBid']}',
                          style: const TextStyle(
                            fontFamily: "Outfit",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 230),
                    child: Row(
                      children: [
                        Text(
                          'Category: ${item['category']}',
                          style: const TextStyle(
                            fontFamily: "Outfit",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 230),
                    child: Row(
                      children: [
                        Text(
                          'Seller: ${item['seller']}',
                          style: const TextStyle(
                            fontFamily: "Outfit",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 230),
                    child: Row(
                      children: [
                        Text(
                          'Time Remaining: ${remainingTime.inDays}d ${remainingTime.inHours % 24}h ${remainingTime.inMinutes % 60}m ${remainingTime.inSeconds % 60}s',
                          style: const TextStyle(
                            fontFamily: "Outfit",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 400, vertical: 10),
                    child: InkWell(
                      onTap: () => show(
                          item['name'], item['currentBid'], item['endDate']),
                      child: Container(
                        width: double.infinity,
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
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          child: Center(
                            child: Text(
                              "Bid now",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: "Outfit",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () =>
                  //       show(item['name'], item['currentBid'], item['endDate']),
                  //   child: const Text('Place Bid'),
                  // ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
