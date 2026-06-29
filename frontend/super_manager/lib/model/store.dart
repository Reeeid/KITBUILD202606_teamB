class Store {
  final int? id;
  final String name;
  final String kanaName;
  final String location;
  final String description;
  final double latitude;
  final double longitude;
  final bool isCheap;

  Store({
    this.id,
    required this.name,
    required this.kanaName,
    required this.location,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.isCheap,
  });
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as int?,
      name: json['name'],
      kanaName: json['kananame'],
      location: json['location'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isCheap: json['is_cheap'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'kananame': kanaName,
      'location': location,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'is_cheap': isCheap,
    };
  }
}
