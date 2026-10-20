class ProductModel {
  final int id;
  final String imageUri;
  final String brand;
  final String title;
  final double rate;
  final String description;
  final double price;
  final double discountPercentage;
  final String category;
  final List<String> images;
  final List<String> tags;
  final int stock;
  final String availabilityStatus;
  final String sku;
  final String warrantyInformation;
  final String shippingInformation;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final List<ProductReview> reviews;

  ProductModel({
    required this.id,
    required this.imageUri,
    required this.brand,
    required this.title,
    required this.rate,
    required this.description,
    required this.price,
    required this.discountPercentage,
    this.category = '',
    this.images = const [],
    this.tags = const [],
    this.stock = 0,
    this.availabilityStatus = '',
    this.sku = '',
    this.warrantyInformation = '',
    this.shippingInformation = '',
    this.returnPolicy = '',
    this.minimumOrderQuantity = 1,
    this.reviews = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json["id"] as num?)?.toInt() ?? 0,
      imageUri: json["thumbnail"] as String? ?? "",
      brand: json["brand"] as String? ?? "",
      title: json["title"] as String? ?? "",
      rate: (json["rating"] as num?)?.toDouble() ?? 0,
      description: json["description"] as String? ?? "",
      price: (json["price"] as num?)?.toDouble() ?? 0,
      discountPercentage: (json["discountPercentage"] as num?)?.toDouble() ?? 0,
      category: json["category"] as String? ?? "",
      images: (json["images"] as List<dynamic>? ?? [])
          .whereType<String>()
          .toList(),
      tags: (json["tags"] as List<dynamic>? ?? []).whereType<String>().toList(),
      stock: (json["stock"] as num?)?.toInt() ?? 0,
      availabilityStatus: json["availabilityStatus"] as String? ?? "",
      sku: json["sku"] as String? ?? "",
      warrantyInformation: json["warrantyInformation"] as String? ?? "",
      shippingInformation: json["shippingInformation"] as String? ?? "",
      returnPolicy: json["returnPolicy"] as String? ?? "",
      minimumOrderQuantity:
          (json["minimumOrderQuantity"] as num?)?.toInt() ?? 1,
      reviews: (json["reviews"] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(ProductReview.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "thumbnail": imageUri,
      "brand": brand,
      "title": title,
      "rating": rate,
      "description": description,
      "price": price,
      "discountPercentage": discountPercentage,
      "category": category,
      "images": images,
      "tags": tags,
      "stock": stock,
      "availabilityStatus": availabilityStatus,
      "sku": sku,
      "warrantyInformation": warrantyInformation,
      "shippingInformation": shippingInformation,
      "returnPolicy": returnPolicy,
      "minimumOrderQuantity": minimumOrderQuantity,
      "reviews": reviews.map((review) => review.toJson()).toList(),
    };
  }
}

class ProductReview {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;

  const ProductReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      rating: (json["rating"] as num?)?.toInt() ?? 0,
      comment: json["comment"] as String? ?? "",
      date: json["date"] as String? ?? "",
      reviewerName: json["reviewerName"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rating": rating,
      "comment": comment,
      "date": date,
      "reviewerName": reviewerName,
    };
  }
}
