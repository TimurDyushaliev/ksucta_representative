class ProductModel {
  const ProductModel(
      {required this.name, required this.startDate, required this.amount});

  final String name;
  final String startDate;
  final int amount;

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      startDate: map['startDate'] as String,
      amount: map['amount'] as int,
    );
  }

  factory ProductModel.fromTexts(List<String> texts) {
    return ProductModel(
      name: texts[0],
      startDate: texts[1],
      amount: int.parse(texts[2]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'startDate': startDate,
      'amount': amount,
    };
  }

  ProductModel copyWith({
    String? name,
    String? startDate,
    int? amount,
  }) =>
      ProductModel(
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        amount: amount ?? this.amount,
      );
}
