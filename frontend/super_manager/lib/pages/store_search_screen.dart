import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:super_manager/model/store.dart';

class StoreSearchScreen extends StatefulWidget {
  const StoreSearchScreen({super.key});

  @override
  State<StoreSearchScreen> createState() => _StoreSearchScreenState();
}

class _StoreSearchScreenState extends State<StoreSearchScreen> {
  // モックストア(検索用)
  final List<Store> _allStores = List.generate(
    100,
    (index) => Store(
      name: 'ナショナル $index号店',
      kanaName: 'なしょなる $indexごうてん',
      location: '大阪市',
      description: 'なしょなるだよ',
    ),
  );

  List<Store> _displayedStores = [];
  final TextEditingController _searchController = TextEditingController();

  void _searchStores(String query) {
    if (query.isEmpty) {
      setState(() {
        _displayedStores = List.from(_allStores);
      });
      return;
    }

    List<Map<String, dynamic>> scoredStores = _allStores.map((store) {
      double nameScore = query.similarityTo(store.name);
      double kanaScore = query.similarityTo(store.kanaName);
      double maxScore = nameScore > kanaScore ? nameScore : kanaScore;
      return {'store': store, 'score': maxScore};
    }).toList();
    scoredStores.sort((a, b) => b['score'].compareTo(a['score']));

    setState(() {
      _displayedStores = scoredStores
          .where((item) => item['score'] > 0.1)
          .map<Store>((item) => item['store'] as Store)
          .toList();
    });
  }

  //google map logic
  bool _isPinMode = false;
  Set<Marker> _markers = {};

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _addMarker(LatLng latLng) {
    final marker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
    );
    setState(() {
      _markers = {..._markers, marker};
      _isPinMode = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _displayedStores = List.from(_allStores);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: '店舗名を入力',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _searchStores,
                ), // 文字が入力されるたびに検索を実行
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    primary: true,
                    itemCount: _displayedStores.length,
                    itemBuilder: (context, index) {
                      final store = _displayedStores[index];
                      return Card(
                        child: ListTile(
                          title: Text(store.name),
                          subtitle: Text(store.location),
                          trailing: Text(store.description),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                markers: _markers,
                style: '''[
                        {
                        "featureType": "poi",
                        "stylers": [{"visibility": "off"}]
                        }
                        ]''',
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                onTap: (LatLng latLng) {
                  if (_isPinMode) {
                    _addMarker(latLng);
                  }
                },
              ),
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () async {
                      await Future.delayed(Duration(microseconds: 300));
                      setState(() {
                        _isPinMode = !_isPinMode;
                      });
                    },
                    child: Icon(_isPinMode ? Icons.cancel : Icons.add_location),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
