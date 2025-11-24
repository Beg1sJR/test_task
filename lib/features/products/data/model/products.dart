// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? id;
  final int? userId;
  final String? name;
  final String? description;
  final double? price;
  final DateTime? createdAt;
  const ProductModel({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.price,
    this.createdAt,
  });

  ProductModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    double? price,
    DateTime? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'price': price,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) : null,
      userId: map['user_id'] != null
          ? int.tryParse(map['user_id'].toString())
          : null,
      name: map['name']?.toString(),
      description: map['description']?.toString(),
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(map['created_at'].toString()) ?? 0,
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, userId, name, description, price, createdAt];
  }
}
