import 'package:flutter/material.dart';
import 'package:super_manager/pages/product_list_page.dart'; 

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 検索窓に入力された文字を管理
    final searchController = TextEditingController();

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
                          controller: searchController, // コントローラーをセット
                          decoration: InputDecoration(
                            hintText: 'キーワードを入力',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                // 虫眼鏡アイコンをクリックしたときも検索を実行
                                _onSearch(context, searchController.text);
                              },
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          // キーボードの「検索」や「エンター」が押されたときの処理
                          onSubmitted: (value) {
                            _onSearch(context, value);
                          },
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

  // 検索を実行
  void _onSearch(BuildContext context, String query) {
    // もし何も入力されていなければ何もしない
    if (query.trim().isEmpty) return;

    // 入力された商品の名前（例: キャベツ）の金額比較ページに移動
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(productName: query.trim()),
      ),
    );
  }

  // カテゴリボタン
  Widget _buildCategoryButton(BuildContext context, String label) { 
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductListPage(categoryName: label),
          ),
        );
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