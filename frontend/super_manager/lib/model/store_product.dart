//商品IDで取ってきた店のリストと値段を取るための型
class StoreProduct {
  final int storeId;
  final String storeName;
  final String location;
  final int productId;
  final int price;
  StoreProduct({
    required this.storeId,
    required this.storeName,
    required this.location,
    required this.productId,
    required this.price,
  });
}
