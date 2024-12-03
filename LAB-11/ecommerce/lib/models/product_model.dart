import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  bool isFavorite;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.isFavorite = false,
  });

  // JSON -> ProductModel object
  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  
  // ProductModel object -> JSON
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // API Response -> List<ProductModel>
  static List<ProductModel> fromList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Үнийг аюулгүй авах (null биш)
  double get safePrice => price ?? 0.0;
}

@JsonSerializable(createToJson: false)
class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return _$RatingFromJson(json);
  }
}