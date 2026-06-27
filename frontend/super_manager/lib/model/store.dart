class Store {
  final int id;
  final String name;
  final String kanaName;
  final String location;
  final String description;
  final double latitude;
  final double longitude;
  final bool isCheap;

  Store({
    required this.id,
    required this.name,
    required this.kanaName,
    required this.location,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.isCheap,
  });
}
