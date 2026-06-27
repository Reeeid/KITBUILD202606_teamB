import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final String categoryName;

  const ProductListPage({super.key, required this.categoryName});

  // カテゴリごとに表示する商品を切り替える
  static const Map<String, List<Map<String, String>>> _categoryProducts = {
    '野菜': [
      {'name': 'キャベツ', 'price': '150円〜'},
      {'name': 'レタス', 'price': '168円〜'},
      {'name': 'トマト', 'price': '98円〜'},
      {'name': '玉ねぎ', 'price': '50円〜'},
      {'name': 'にんじん', 'price': '60円〜'},
      {'name': '大根', 'price': '198円〜'},
    ],
    '果物': [
      {'name': 'りんご', 'price': '120円〜'},
      {'name': 'バナナ', 'price': '98円〜'},
      {'name': 'みかん', 'price': '80円〜'},
      {'name': 'いちご', 'price': '398円〜'},
      {'name': 'ぶどう', 'price': '450円〜'},
    ],
    '肉': [
      {'name': '鶏もも肉', 'price': '98円/100g〜'},
      {'name': '豚バラ肉', 'price': '148円/100g〜'},
      {'name': '牛肩ロース', 'price': '298円/100g〜'},
    ],
    '魚': [
      {'name': '鮭の切り身', 'price': '120円〜'},
      {'name': 'サバ', 'price': '150円〜'},
      {'name': 'マグロ（刺身）', 'price': '398円〜'},
    ],
    '乳製品': [
      {'name': '牛乳', 'price': '198円〜'},
      {'name': 'ヨーグルト', 'price': '128円〜'},
      {'name': 'チーズ', 'price': '248円〜'},
    ],
    '調味料': [
      {'name': '醤油', 'price': '218円〜'},
      {'name': 'みりん', 'price': '188円〜'},
      {'name': '塩', 'price': '100円〜'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    // 選択されたカテゴリの商品リストを取得する
    final products = _categoryProducts[categoryName] ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 戻るボタンとタイトル
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 20),
                Text(
                  categoryName,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 商品一覧（カテゴリに応じて自動で生成）
            Expanded(
              child: products.isEmpty
                  ? const Center(child: Text('商品が登録されていません'))
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,        // 5列に並べる
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.8,    // 縦長のカード型にする
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _buildProductCard(
                          context,
                          product['name']!,
                          product['price']!,
                        );
                      },
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(productName: name),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: Text('写真', style: TextStyle(color: Colors.black54)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(price, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProductPriceData {
  final int price;
  final int gram;
  final double unitPrice; // 100gあたりの価格
  final String shopInfo;

  ProductPriceData({
    required this.price,
    required this.gram,
    required this.unitPrice,
    required this.shopInfo,
  });
}


class ProductDetailPage extends StatefulWidget {
  final String productName;
  const ProductDetailPage({super.key, required this.productName});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // 初期データ（モックデータ）をリストで持たせる
  final List<ProductPriceData> _priceList = [
    ProductPriceData(price: 150, gram: 100, unitPrice: 15.0, shopInfo: 'スーパーA ・ 〇〇店'),
    ProductPriceData(price: 168, gram: 100, unitPrice: 16.8, shopInfo: 'スーパーB ・ △△店'),
    ProductPriceData(price: 198, gram: 100, unitPrice: 19.8, shopInfo: 'スーパーC ・ □□店'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 30,
            color: Colors.lightGreen,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 戻るボタン、商品名、並べ替え表示
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 36),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(width: 40),
                      Text(
                        widget.productName, // StatefulWidgetなので widget. が必要
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Text(
                        '安い順',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.swap_vert, size: 28),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // 価格・店舗情報の比較テーブル
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          headingRowHeight: 56,
                          dataRowMaxHeight: 64,
                          horizontalMargin: 24,
                          columnSpacing: 40,
                          border: TableBorder.all(color: Colors.black12, width: 1),
                          columns: const [
                            DataColumn(
                              label: Text('価格', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('単位あたり金額', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('店舗情報', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                          ],
                          // リストの中身をループさせて行（DataRow）を自動生成する
                          rows: _priceList.map((data) {
                            return DataRow(
                              cells: [
                                DataCell(Text('${data.price}円', style: const TextStyle(fontSize: 20))),
                                DataCell(Text('${data.unitPrice.toStringAsFixed(1)}円/100g', style: const TextStyle(fontSize: 18, color: Colors.black54))),
                                DataCell(Text(data.shopInfo, style: const TextStyle(fontSize: 18))),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // 右下のプラスボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final priceController = TextEditingController();
              final gramController = TextEditingController();
              final shopController = TextEditingController();

              return AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                titlePadding: EdgeInsets.zero,
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
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: '値段',
                          hintText: '例: 150',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: gramController,
                        decoration: const InputDecoration(
                          labelText: 'グラム',
                          hintText: '例: 100',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: shopController,
                        decoration: const InputDecoration(
                          labelText: '店舗名',
                          hintText: '例: スーパーA 〇〇店',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('キャンセル', style: TextStyle(color: Colors.black54)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 入力された値を数値に変換
                      final int inputPrice = int.tryParse(priceController.text) ?? 0;
                      final int inputGram = int.tryParse(gramController.text) ?? 0;
                      final String inputShop = shopController.text.isEmpty ? '不明な店舗' : shopController.text;

                      // 100gあたりの金額を自動計算する (価格 ÷ グラム × 100)
                      double computedUnitPrice = 0.0;
                      if (inputGram > 0) {
                        computedUnitPrice = (inputPrice / inputGram) * 100;
                      }

                      //使ってデータを追加し、画面をリフレッシュする
                      setState(() {
                        _priceList.add(
                          ProductPriceData(
                            price: inputPrice,
                            gram: inputGram,
                            unitPrice: computedUnitPrice,
                            shopInfo: inputShop,
                          ),
                        );

                        // 単位あたり金額が「安い順」になるようにリストをソートする
                        _priceList.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
                      });

                      Navigator.pop(context); // ダイアログを閉じる
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('追加'),
                  ),
                ],
              );
            },
          );
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
}