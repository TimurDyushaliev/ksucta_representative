class StoreModel {
  const StoreModel({
    required this.name,
    required this.address,
  });

  final String name;
  final String address;

  factory StoreModel.fromMap(Map<dynamic, dynamic> map) {
    return StoreModel(
      name: map['name'] as String,
      address: map['address'] as String,
    );
  }

  factory StoreModel.fromTexts(List<String> texts) {
    return StoreModel(
      name: texts[0],
      address: texts[1],
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'address': address,
    };
  }
}
