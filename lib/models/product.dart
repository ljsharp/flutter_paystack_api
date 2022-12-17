// class Product {
//   int? id;
//   String? title;
//   String? description;
//   int? price;
//   double? discountPercentage;
//   double? rating;
//   int? stock;
//   String? brand;
//   String? category;
//   String? thumbnail;
//   List<String>? images;

//   Product(
//       {this.id,
//       this.title,
//       this.description,
//       this.price,
//       this.discountPercentage,
//       this.rating,
//       this.stock,
//       this.brand,
//       this.category,
//       this.thumbnail,
//       this.images});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     price = json['price'];
//     discountPercentage = json['discountPercentage'];
//     rating = json['rating'] is int
//         ? double.parse(json['rating'].toString())
//         : json['rating'] as double;
//     stock = json['stock'];
//     brand = json['brand'];
//     category = json['category'];
//     thumbnail = json['thumbnail'];
//     images = json['images'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['price'] = price;
//     data['discountPercentage'] = discountPercentage;
//     data['rating'] = rating;
//     data['stock'] = stock;
//     data['brand'] = brand;
//     data['category'] = category;
//     data['thumbnail'] = thumbnail;
//     data['images'] = images;
//     return data;
//   }
// }

class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'] is int
        ? double.parse(json['price'].toString())
        : json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'] is int
        ? double.parse(json['rate'].toString())
        : json['rate'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}
