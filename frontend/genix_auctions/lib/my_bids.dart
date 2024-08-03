import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BidsPage extends StatefulWidget {
  @override
  _BidsPageState createState() => _BidsPageState();
}

class _BidsPageState extends State<BidsPage> {
  List<dynamic> _bids = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchBids();
  }

  Future<void> _fetchBids() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/api/users/user-bids'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _bids = data['bids'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load bids';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bids'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : ListView.builder(
                  itemCount: _bids.length,
                  itemBuilder: (context, index) {
                    final bid = _bids[index];
                    return ListTile(
                      title: Text(bid['productName']),
                      subtitle: Text('Price: \$${bid['price'].toString()}'),
                      trailing: Text(bid['time']),
                    );
                  },
                ),
    );
  }
}
