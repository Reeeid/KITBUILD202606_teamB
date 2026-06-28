import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String productName;

  const ProductDetailPage({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左側のバー
          Container(
            width: 30,
            color: Colors.lightGreen,
          ),
          
          // メイン
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
                        productName,
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
                          rows: [
                            //仮のデータ
                            _buildDataRow('150円', '15.0円/100g', 'スーパーA ・ 〇〇店'),
                            _buildDataRow('168円', '16.8円/100g', 'スーパーB ・ △△店'),
                            _buildDataRow('198円', '19.8円/100g', 'スーパーC ・ □□店'),
                          ],
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
          // プラスボタンが押されたら、入力フォームを表示する
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
                // 追加画面
                titlePadding: EdgeInsets.zero,
                title: Container(
                  height: 40,
                  color: Colors.lightGreen,
                ),
                content: SizedBox(
                  width: 400, // 横幅
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 中身の高さに合わせる
                    children: [
                      const SizedBox(height: 20),
                      TextField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: '値段',
                          hintText: '例: 150',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number, // 数字キーボードにする
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
                    onPressed: () => Navigator.pop(context), // キャンセルして閉じる
                    child: const Text('キャンセル', style: TextStyle(color: Colors.black54)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // ここで入力された値を取得
                      print('値段: ${priceController.text}');
                      print('グラム: ${gramController.text}');
                      print('店舗名: ${shopController.text}');
                      
                      // 画面を閉じる
                      Navigator.pop(context);
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

  // テーブルの行を作る
  DataRow _buildDataRow(String price, String unitPrice, String shopInfo) {
    return DataRow(
      cells: [
        DataCell(Text(price, style: const TextStyle(fontSize: 20))),
        DataCell(Text(unitPrice, style: const TextStyle(fontSize: 18, color: Colors.black54))),
        DataCell(Text(shopInfo, style: const TextStyle(fontSize: 18))),
      ],
    );
  }
}