import 'package:ecommerce_flutter/domain/entities/product/price_tag.dart';
import 'package:equatable/equatable.dart';
import '../entities/product/product.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final PriceTag priceTag;

  CartItem({required this.id, required this.product, required this.priceTag});

  @override
  List<Object?> get props => [id];
}
