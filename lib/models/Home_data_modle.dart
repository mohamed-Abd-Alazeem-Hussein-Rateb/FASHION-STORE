class HomeDataModle {
  int? id;
  String? name;
  String? image;
  double? price; // تغيير إلى double
  double? oldPrice; // تغيير إلى double
  String? description;
  double? discount; // تغيير إلى double

  HomeDataModle({this.id, this.name, this.image, this.price, this.oldPrice, this.description, this.discount});

  factory HomeDataModle.fromJson(Map<String, dynamic> json) {
    return HomeDataModle(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] as double, // تحويل إلى double إذا كان int
      oldPrice: (json['old_price'] is int) ? (json['old_price'] as int).toDouble() : json['old_price'] as double, // تحويل إلى double إذا كان int
      description: json['description'],
      discount: (json['discount'] is int) ? (json['discount'] as int).toDouble() : json['discount'] as double, // تحويل إلى double إذا كان int
    );
  }

  @override
  String toString() {
    return 'HomeDataModle(id: $id, name: $name, image: $image, price: $price, oldPrice: $oldPrice, description: $description, discount: $discount)';
  }
}
