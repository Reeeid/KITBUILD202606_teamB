import 'package:flutter/material.dart';

class MapFormModal extends StatefulWidget {
  const MapFormModal({super.key});

  @override
  State<MapFormModal> createState() => _MapFormModalState();
}

class _MapFormModalState extends State<MapFormModal> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "店舗名を入力してください";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "店舗名",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "店舗名（かな）を入力してください";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "店舗名（かな）",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "住所を入力してください";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "店舗住所",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "説明",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: (() {
              if (_formKey.currentState!.validate()) {
                print("test");
              }
            }),
            child: Text("登録"),
          ),
        ],
      ),
    );
  }
}
