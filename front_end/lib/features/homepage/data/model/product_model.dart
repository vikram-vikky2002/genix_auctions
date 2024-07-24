import 'package:genix_auctions/features/homepage/domain/entity/product_model.dart';

class ProductIteam extends ProductModel {
  const ProductIteam({
    required super.id,
    required super.title,
    required super.minBid,
    required super.currentBid,
    required super.endTime,
  });
}
