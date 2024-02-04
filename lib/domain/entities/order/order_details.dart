import 'package:ecommerce_flutter/domain/entities/user/delivery_info.dart';
import 'package:equatable/equatable.dart';

import 'order_item.dart';

class OrderDetails extends Equatable {
  final String id;
  final DeliveryInfo deliveryInfo;
  final List<OrderItem> items;
  final num discount;

  OrderDetails(
      {required this.id,
      required this.deliveryInfo,
      required this.items,
      required this.discount});

  @override
  List<Object?> get props => [id];
}
