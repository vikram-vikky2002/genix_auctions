import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.itemId});

  final String itemId;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  Map? data;

  Future<Map<String, dynamic>> fetchItemById(String id) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/v1/items/$id'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load item');
    }
  }

  fetchData() async {
    setState(() async {
      data = await fetchItemById(widget.itemId);
    });
  }

  @override
  void initState() {
    super.initState();
    item = fetchItemById(widget.itemId);
  }

  late Future<Map<String, dynamic>> item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: item,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Item not found'));
          } else {
            var itemData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${itemData['name']}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 8),
                  Text('Description: ${itemData['description']}'),
                  const SizedBox(height: 8),
                  Text('Minimum Bid: ${itemData['minimumBid']}'),
                  const SizedBox(height: 8),
                  Text('Current Bid: ${itemData['currentBid']}'),
                  const SizedBox(height: 8),
                  Text('Category: ${itemData['category']}'),
                  const SizedBox(height: 8),
                  Text('Seller: ${itemData['seller']}'),
                  const SizedBox(height: 8),
                  Text('End Date: ${itemData['endDate']}'),
                  const SizedBox(height: 8),
                  Text('Status: ${itemData['status']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
