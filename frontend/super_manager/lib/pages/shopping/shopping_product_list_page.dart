import 'package:flutter/material.dart';
import 'package:super_manager/model/product.dart';

class ShoppingProductListPage extends StatelessWidget {
  const ShoppingProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 戻るボタンとタイトル（野菜）
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    // 1つ前の画面（カテゴリ画面）に戻る
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 20),
                const Text(
                  '野菜',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 商品一覧
            Expanded(
              child: GridView.count(
                crossAxisCount: 5, // 5列に並べる
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.8, // 縦長のカード型にする
                children: [
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                  _buildProductCard(context, '商品名', '〇〇円'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 商品カード（写真枠＋名前＋価格）
  Widget _buildProductCard(BuildContext context, String name, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, Product(name: 'マヨネーズ', categoryId: 1));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            // 写真が入るグレーの枠
            Expanded(
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: Text('写真', style: TextStyle(color: Colors.black54)),
                ),
              ),
            ),
            // テキスト部分
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
