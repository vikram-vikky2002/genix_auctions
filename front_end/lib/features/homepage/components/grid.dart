import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponsiveGridView extends StatelessWidget {
  final Stream<List<dynamic>>? itemsStream;
  final int count;

  const ResponsiveGridView(
      {super.key, required this.itemsStream, required this.count});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final screenWidth = constraints.maxWidth;
        // double cardWidth;
        // int crossAxisCount;

        // if (screenWidth > 1300) {
        //   crossAxisCount = 4;
        // } else if (screenWidth > 850) {
        //   crossAxisCount = 3;
        // } else if (screenWidth > 600) {
        //   crossAxisCount = 2;
        // } else {
        //   crossAxisCount = 1;
        // }

        // cardWidth = (screenWidth / crossAxisCount) - 20;

        return StreamBuilder<List<dynamic>>(
          stream: itemsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No items found'));
            } else {
              List<Map<String, dynamic>> items =
                  snapshot.data!.cast<Map<String, dynamic>>();

              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      count > items.length ? items.length : count,
                      (index) {
                        return SizedBox(
                          width: 250,
                          height: 290,
                          child: InkWell(
                            onTap: () => context
                                .go('/itemDetails/${items[index]['_id']}'),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Hero(
                                      tag: "ProductImage${items[index]['_id']}",
                                      child: Container(
                                        height: 130, // Adjusted height
                                        decoration: BoxDecoration(
                                          gradient:
                                              const LinearGradient(colors: [
                                            Colors.blue,
                                            Colors.redAccent,
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      items[index]['name'],
                                      style: const TextStyle(
                                        fontFamily: "Outfit-Bold",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Minimum bid",
                                          style: TextStyle(
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                        Text(
                                          "\$ ${items[index]['minimumBid']}",
                                          style: const TextStyle(
                                            fontFamily: "Outfit-Bold",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Current bid",
                                          style: TextStyle(
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                        Text(
                                          "\$ ${items[index]['currentBid']}",
                                          style: const TextStyle(
                                            fontFamily: "Outfit-Bold",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
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
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            "Bid now",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontFamily: "Outfit",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
