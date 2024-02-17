import 'package:ecommerce_flutter/domain/entities/category/category.dart';
import 'package:ecommerce_flutter/domain/entities/product/price_tag.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final PriceTag priceTags;
  final List<Category> categories;
  final List<String> images;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.priceTags,
      required this.categories,
      required this.images,
      required this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props => [id];
}
