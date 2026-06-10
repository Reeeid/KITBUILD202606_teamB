import 'package:flutter/material.dart';

class StoreMap extends StatelessWidget {
  const StoreMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  primary: true,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('ナショナル $index号店'),
                      subtitle: Text('大阪市'),
                      trailing: Text('なしょなるだよ'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
