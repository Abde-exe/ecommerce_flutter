import 'package:equatable/equatable.dart';

class PriceTag extends Equatable {
  final String id;
  final String name;
  final num price;

  PriceTag(this.id, this.name, this.price);

  @override
  List<Object?> get props => [id];
}
