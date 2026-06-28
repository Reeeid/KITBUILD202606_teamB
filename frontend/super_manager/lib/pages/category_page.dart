import 'package:flutter/material.dart';
import 'package:super_manager/pages/product_list_page.dart'; 

// ★ 正しい StatefulWidget の形に修正
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // 検索窓に入力された文字を管理
  final searchController = TextEditingController();

  //現在のカテゴリ一覧（状態）を保存
  final List<String> _categories = ['野菜', '果物', '肉', '魚', '乳製品', '調味料'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 右側
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
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'キーワードを入力',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                _onSearch(context, searchController.text);
                              },
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          onSubmitted: (value) {
                            _onSearch(context, value);
                          },
                        ),
                      ),
                      const SizedBox(width: 40),
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
                    // リストの中身が増えたら自動でボタンが増える
                    child: GridView.builder(
                      itemCount: _categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,       // 3列に並べる
                        mainAxisSpacing: 20,     // 縦のすきま
                        crossAxisSpacing: 20,    // 横のすきま
                        childAspectRatio: 1.2,   // ボタンの縦横比
                      ),
                      itemBuilder: (context, index) {
                        return _buildCategoryButton(context, _categories[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  // 検索を実行
  void _onSearch(BuildContext context, String query) {
    if (query.trim().isEmpty) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(productName: query.trim(), priceList: []),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: Container(
            height: 40,
            color: Colors.lightGreen,
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '商品名',
                    hintText: '例: 野菜',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.lightGreen, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.lightGreen, width: 2.0),
                    ),
                  ),
                  autofocus: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('キャンセル', style: TextStyle(color: Colors.black54)),
            ),
            ElevatedButton(
              onPressed: () {
                final productName = nameController.text.trim();
                if (productName.isEmpty) return;

                //リストにデータを保存して、画面を更新
                setState(() {
                  _categories.add(productName);
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text('追加'),
            ),
          ],
        );
      },
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