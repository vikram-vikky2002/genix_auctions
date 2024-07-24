import 'dart:convert';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String minBid;
  final String currentBid;
  final DateTime endTime;

  const ProductModel({
    required this.id,
    required this.title,
    required this.minBid,
    required this.currentBid,
    required this.endTime,
  });

  @override
  List<Object?> get props => [id, title, minBid, currentBid, endTime];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'minBid': minBid,
      'currentBid': currentBid,
      'endTime': endTime.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: (map["id"] ?? 0) as int,
      title: (map["title"] ?? '') as String,
      minBid: (map["minBid"] ?? '') as String,
      currentBid: (map["currentBid"] ?? '') as String,
      endTime:
          DateTime.fromMillisecondsSinceEpoch((map["endTime"] ?? 0) as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
