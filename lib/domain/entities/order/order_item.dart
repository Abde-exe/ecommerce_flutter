import 'package:ecommerce_flutter/domain/entities/product/price_tag.dart';
import 'package:ecommerce_flutter/domain/entities/product/product.dart';
import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String id;
  final Product product;
  final PriceTag priceTag;
  final num quantity;
  final num price;

  OrderItem(
      {required this.id,
      required this.product,
      required this.priceTag,
      required this.quantity,
      required this.price});

  @override
  List<Object?> get props => [id];
}
