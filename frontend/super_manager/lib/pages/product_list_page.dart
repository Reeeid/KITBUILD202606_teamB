import 'package:flutter/material.dart';

class ProductPriceData {
  final int price;
  final int gram;
  final double unitPrice; 
  final String shopInfo;

  ProductPriceData({
    required this.price,
    required this.gram,
    required this.unitPrice,
    required this.shopInfo,
  });
}

final Map<String, List<Map<String, dynamic>>> _globalCategoryProducts = {
  '野菜': [
    {
      'name': 'キャベツ', 
      'kana': 'きゃべつ', 
      'isFavorite': 'false',
      'prices': <ProductPriceData>[
        ProductPriceData(price: 150, gram: 100, unitPrice: 15.0, shopInfo: 'スーパーA ・ 〇〇店'),
        ProductPriceData(price: 168, gram: 100, unitPrice: 16.8, shopInfo: 'スーパーB ・ △△店'),
        ProductPriceData(price: 198, gram: 100, unitPrice: 19.8, shopInfo: 'スーパーC ・ □□店'),
      ]
    },
    {
      'name': 'レタス', 
      'kana': 'れたす', 
      'isFavorite': 'false',
      'prices': <ProductPriceData>[
        ProductPriceData(price: 168, gram: 100, unitPrice: 16.8, shopInfo: 'スーパーB ・ △△店'),
      ]
    },
    {
      'name': 'トマト', 
      'kana': 'とまと', 
      'isFavorite': 'false',
      'prices': <ProductPriceData>[
        ProductPriceData(price: 98, gram: 100, unitPrice: 9.8, shopInfo: 'スーパーA ・ 〇〇店'),
      ]
    },
    {
      'name': '玉ねぎ', 
      'kana': 'たまねぎ', 
      'isFavorite': 'false',
      'prices': <ProductPriceData>[
        ProductPriceData(price: 50, gram: 100, unitPrice: 5.0, shopInfo: 'スーパーA ・ 〇〇店'),
      ]
    },
    {
      'name': 'にんじん', 
      'kana': 'にんじん', 
      'isFavorite': 'false',
      'prices': <ProductPriceData>[
        ProductPriceData(price: 60, gram: 100, unitPrice: 6.0, shopInfo: 'スーパーC ・ □□店'),
      ]
    },
    {
      'name': '大根', 
      'kana': 'だいこん', 
      'isFavorite': 'false',
      'prices': <ProductPriceData>[
        ProductPriceData(price: 198, gram: 100, unitPrice: 19.8, shopInfo: 'スーパーB ・ △△店'),
      ]
    },
  ],
  '果物': [
    {'name': 'りんご', 'kana': 'りんご', 'isFavorite': 'false', 'prices': <ProductPriceData>[]},
    {'name': 'バナナ', 'kana': 'ばなな', 'isFavorite': 'false', 'prices': <ProductPriceData>[]},
    {'name': 'みかん', 'kana': 'みかん', 'isFavorite': 'false', 'prices': <ProductPriceData>[]},
    {'name': 'いちご', 'kana': 'いちご', 'isFavorite': 'false', 'prices': <ProductPriceData>[]},
    {'name': 'ぶどう', 'kana': 'ぶどう', 'isFavorite': 'false', 'prices': <ProductPriceData>[]},
  ],
  '肉': [],
  '魚': [],
  '乳製品': [],
  '調味料': [],
};

class ProductListPage extends StatefulWidget {
  final String categoryName;

  const ProductListPage({super.key, required this.categoryName});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool _showOnlyFavorites = false;

  // 50音順のソート処理
  void _sortCurrentCategory(){
    final products = _globalCategoryProducts[widget.categoryName];
    if(products != null){
      products.sort((a, b) => (a['kana'] as String).compareTo(b['kana'] as String));
    }
  }

  @override
  void initState() {
    super.initState();
    _sortCurrentCategory();
  }

  // 最低価格を自動で計算
  String _getLowestPriceText(List<ProductPriceData> prices) {
    if (prices.isEmpty) return '価格未登録';
    int minPrice = prices.map((p) => p.price).reduce((a, b) => a < b ? a : b);
    return '$minPrice円〜';
  }

  @override
  Widget build(BuildContext context) {
    // 画面の外に引っ越したデータを参照します
    final allProducts = _globalCategoryProducts[widget.categoryName] ?? [];

    final displayProducts = _showOnlyFavorites
        ? allProducts.where((p) => p['isFavorite'] == 'true').toList()
        : allProducts;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  widget.categoryName,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 30),
                FilterChip(
                  label: const Text('お気に入りのみを表示', style: TextStyle(fontWeight: FontWeight.bold)),
                  selected: _showOnlyFavorites,
                  selectedColor: const Color.fromRGBO(139, 195, 74, 0.3),
                  checkmarkColor: Colors.lightGreen[700],
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  side: BorderSide(color: _showOnlyFavorites ? Colors.lightGreen : Colors.black26),
                  onSelected: (bool selected) {
                    setState(() {
                      _showOnlyFavorites = selected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            Expanded(
              child: displayProducts.isEmpty
                  ? Center(
                      child: Text(
                        _showOnlyFavorites ? 'お気に入りに登録された商品がありません' : '商品が登録されていません',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: displayProducts.length,
                      itemBuilder: (context, index) {
                        final product = displayProducts[index];
                        return _buildProductCard(context, product);
                      },
                    ),
            ),
          ],
        ),
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

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          title: Container(height: 40, color: Colors.lightGreen),
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
                    hintText: '例: アスパラ',
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

                setState(() {
                  _globalCategoryProducts[widget.categoryName]?.add({
                    'name': productName,
                    'kana': productName, 
                    'isFavorite': 'false',
                    'prices': <ProductPriceData>[], 
                  });
                  _sortCurrentCategory();
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    final String name = product['name']!;
    final bool isFav = product['isFavorite'] == 'true';
    final List<ProductPriceData> prices = product['prices'] as List<ProductPriceData>;

    final String displayPrice = _getLowestPriceText(prices);

    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productName: name,
              priceList: prices,
            ),
          ),
        );
        setState(() {});
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          displayPrice, 
                          style: const TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      isFav ? Icons.star : Icons.star_border,
                      color: isFav ? Colors.amber : Colors.black26,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        product['isFavorite'] = isFav ? 'false' : 'true';
                      });
                    },
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

// 詳細ページ側（変更なし）
class ProductDetailPage extends StatefulWidget {
  final String productName;
  final List<ProductPriceData> priceList; 

  const ProductDetailPage({
    super.key, 
    required this.productName,
    required this.priceList,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
                        widget.productName, 
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
                          rows: widget.priceList.map((data) { 
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
                      final int inputPrice = int.tryParse(priceController.text) ?? 0;
                      final int inputGram = int.tryParse(gramController.text) ?? 0;
                      final String inputShop = shopController.text.isEmpty ? '不明な店舗' : shopController.text;

                      double computedUnitPrice = 0.0;
                      if (inputGram > 0) {
                        computedUnitPrice = (inputPrice / inputGram) * 100;
                      }

                      setState(() {
                        widget.priceList.add(
                          ProductPriceData(
                            price: inputPrice,
                            gram: inputGram,
                            unitPrice: computedUnitPrice,
                            shopInfo: inputShop,
                          ),
                        );
                        widget.priceList.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
                      });

                      Navigator.pop(context);
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
          ).then((_) {
            setState(() {});
          });
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