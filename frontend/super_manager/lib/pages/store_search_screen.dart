import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:super_manager/model/store.dart';
import 'package:super_manager/components/map_form_modal.dart';
import 'package:super_manager/repository/store_repository.dart';

class StoreSearchScreen extends StatefulWidget {
  const StoreSearchScreen({super.key});

  @override
  State<StoreSearchScreen> createState() => _StoreSearchScreenState();
}

final class _StoreSearchScreenState extends State<StoreSearchScreen> {
  final _storerepo = StoreRepository();
  bool _isDrawerOpen = false;
  // モックストア(検索用)
  final List<Store> _allStores = [];
  List<Store> _displayedStores = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> _loadStores() async {
    final stores = await _storerepo.fetchStores();
    if (!mounted) return;
    setState(() {
      _allStores.clear(); //2重追加阻止
      _allStores.addAll(stores);
      _displayedStores = List.from(_allStores);
    });
  }

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
  bool _isTogglingMode = false;
  Set<Marker> _markers = {};

  final LatLng _center = const LatLng(34.5781, 135.4764);

  Future<void> _addMarker(LatLng latLng) async {
    final screenWidth = MediaQuery.of(context).size.width;
    if (mounted) setState(() => _isPinMode = false);
    final store = await showModalBottomSheet<Store>(
      context: context,
      backgroundColor: Colors.lightGreen[200],
      constraints: BoxConstraints(
        minWidth: screenWidth.clamp(0, 300),
        maxWidth: screenWidth.clamp(0, 800),
        minHeight: 400,
      ),
      builder: (BuildContext context) {
        return Container(
          width: screenWidth * 0.7,
          padding: EdgeInsets.all(16),
          child: MapFormModal(latLng: latLng),
        );
      },
    );
    if (store == null) {
      return;
    }
    await _storerepo.createStore(store);

    final marker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      infoWindow: InfoWindow(title: store.name, snippet: store.location),
    );
    setState(() {
      _markers = {..._markers, marker};
      _allStores.add(store);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStores();
    _displayedStores = List.from(_allStores);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) {
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
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  onTap: (LatLng latLng) {
                    if (_isPinMode && !_isTogglingMode) {
                      _addMarker(latLng);
                    }
                  },
                ),
                Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isTogglingMode = true;
                          _isPinMode = !_isPinMode;
                        });
                        Future.delayed(Duration(milliseconds: 300), () {
                          if (mounted) setState(() => _isTogglingMode = false);
                        });
                      },
                      child: Icon(
                        _isPinMode ? Icons.cancel : Icons.add_location,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          GoogleMap(
            markers: _markers,
            style: '''[
                            {
                            "featureType": "poi",
                            "stylers": [{"visibility": "off"}]
                            }
                            ]''',
            initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
            onTap: (LatLng latLng) {
              if (_isPinMode && !_isTogglingMode) {
                _addMarker(latLng);
              }
            },
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Padding(
              padding: EdgeInsetsGeometry.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isTogglingMode = true;
                    _isPinMode = !_isPinMode;
                  });
                  Future.delayed(Duration(milliseconds: 300), () {
                    if (mounted) setState(() => _isTogglingMode = false);
                  });
                },
                child: Icon(_isPinMode ? Icons.cancel : Icons.add_location),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: _isDrawerOpen ? 0 : -300,
            top: 0,
            bottom: 0,
            width: 300,
            child: Container(
              color: Colors.white,
              child: Listener(
                onPointerDown: (_) {},
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
            ),
          ),
          Align(
            alignment: AlignmentGeometry.topRight,
            child: Padding(
              padding: EdgeInsetsGeometry.all(8.0),
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  setState(() {
                    _isDrawerOpen = !_isDrawerOpen;
                    if (_isDrawerOpen) _isPinMode = false;
                  });
                },
                child: Icon(_isDrawerOpen ? Icons.close : Icons.list),
              ),
            ),
          ),
        ],
      );
    }
  }
}
