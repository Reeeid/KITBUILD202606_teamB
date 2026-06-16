import 'package:flutter/material.dart';
import 'package:super_manager/pages/product_list_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 右側のメインコンテンツエリア
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //検索バー
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'キーワードを入力',
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40), // 右側の余白
                    ],
                  ),
                  const SizedBox(height: 30),

                  //タイトル部分（商品）
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 15, height: 50, color: Colors.lightGreen),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('商品', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  //カテゴリボタンの配置
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,       // 3列に並べる
                      mainAxisSpacing: 20,     // 縦のすきま
                      crossAxisSpacing: 20,    // 横のすきま
                      childAspectRatio: 1.2,   // ボタンの縦横比
                      children: [
                        _buildCategoryButton(context, '野菜'),
                        _buildCategoryButton(context, '果物'),
                        _buildCategoryButton(context, '肉'),
                        _buildCategoryButton(context, '魚'),
                        _buildCategoryButton(context, '乳製品'),
                        _buildCategoryButton(context, '調味料'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // カテゴリボタン(使い回し用)
  Widget _buildCategoryButton(BuildContext context, String label) { 
    return GestureDetector(
      onTap: () {
        if (label == '野菜') { // もし押されたボタンが「野菜」なら
          Navigator.of(context).push( // 画面移動
            MaterialPageRoute(builder: (context) => const ProductListPage()),
          );
        }
      },
      child: Container( 
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}