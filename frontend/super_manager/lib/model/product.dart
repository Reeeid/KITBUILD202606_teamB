class Product {
  final int id;
  final String name;
  final int categoryId;
  Product({required this.id, required this.name, required this.categoryId});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['age'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'category_id': categoryId};
  }
}
