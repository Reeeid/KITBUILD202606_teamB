import 'package:flutter/material.dart';
import 'package:super_manager/model/store.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapFormModal extends StatefulWidget {
  const MapFormModal({super.key, required this.latLng});
  final LatLng latLng;

  @override
  State<MapFormModal> createState() => _MapFormModalState();
}

class _MapFormModalState extends State<MapFormModal> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'kananame': TextEditingController(),
    'location': TextEditingController(),
    'description': TextEditingController(),
  };
  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controllers['name'],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '店舗名を入力してください';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: '店舗名',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          TextFormField(
            controller: _controllers['kananame'],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '店舗名（かな）を入力してください';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: '店舗名（かな）',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          TextFormField(
            controller: _controllers['location'],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '住所を入力してください';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: '店舗住所',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          TextFormField(
            controller: _controllers['description'],
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: '説明',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: (() {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(
                  context,
                  Store(
                    id: 1,
                    name: _controllers['name']!.text,
                    kanaName: _controllers['kananame']!.text,
                    location: _controllers['location']!.text,
                    description: _controllers['description']!.text,
                    latitude: widget.latLng.latitude,
                    longitude: widget.latLng.longitude,
                    isCheap: true,
                  ),
                );
              }
            }),
            child: Text('登録'),
          ),
        ],
      ),
    );
  }
}
