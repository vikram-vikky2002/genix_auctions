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
}
