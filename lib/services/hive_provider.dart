import 'package:accident_registration/models/product_model.dart';
import 'package:accident_registration/models/store_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProvider {
  static late final Box<Map<dynamic, dynamic>> _storesBox;
  static late final Box<Map<dynamic, dynamic>> _productsBox;

  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    _storesBox = await Hive.openBox<Map<dynamic, dynamic>>('stores');
    _productsBox = await Hive.openBox<Map<dynamic, dynamic>>('products');
  }

  static Stream<BoxEvent> storesStream() => _storesBox.watch();

  static Stream<BoxEvent> productsStream() => _productsBox.watch();

  static List<StoreModel> getStores() {
    final maps = _storesBox.values;
    return maps.map((map) => StoreModel.fromMap(map)).toList();
  }

  static List<ProductModel> getProducts() {
    final maps = _productsBox.values;
    return maps.map((map) => ProductModel.fromMap(map)).toList();
  }

  static Future<int> saveStore(StoreModel model) =>
      _storesBox.add(model.toJson());

  static Future<int> saveProduct(ProductModel model) =>
      _productsBox.add(model.toJson());

  static Future<void> deleteStore(int index) => _storesBox.deleteAt(index);

  static Future<void> deleteProduct(int index) => _productsBox.deleteAt(index);

  static Future<void> updateProduct(
    int index,
    ProductModel model,
  ) =>
      _productsBox.putAt(
        index,
        model.toJson(),
      );
}
