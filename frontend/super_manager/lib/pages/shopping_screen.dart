import 'package:flutter/material.dart';

import 'package:super_manager/model/product.dart';
import 'package:super_manager/model/store.dart';
import 'package:super_manager/pages/shopping/shopping_category_page.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final Store _store = Store(
    name: 'スーパーA',
    kanaName: 'すーぱーえー',
    location: 'ACT314',
    description: '安売り多め',
    latitude: 35.0,
    longitude: 135.0,
    isCheap: true,
  );
  final List<Product> _items = [Product(id: 1, name: "とまと", categoryId: 1)];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        alignment: AlignmentGeometry.center,
        child: Padding(
          padding: EdgeInsetsGeometry.all(30.0),
          child: Column(
            spacing: 16.0,
            children: [
              Flexible(
                flex: 6,
                child: Card(
                  child: SizedBox.expand(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Icon(Icons.shopping_bag),
                                      title: Text(_items[index].name),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 48),
                              backgroundColor: Colors.lightGreen[200],
                            ),
                            onPressed: () async {
                              final item = await Navigator.push<Product>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ShoppingCategoryPage(),
                                ),
                              );
                              if (item != null) {
                                setState(() => _items.add(item));
                              }
                            },
                            child: Text('+ 商品追加'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: const Icon(Icons.image, size: 48),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(8.0),
                            child: Column(
                              spacing: 4.0,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _store.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(_store.location),
                                Text(_store.description),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
