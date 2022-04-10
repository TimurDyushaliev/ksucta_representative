import 'package:accident_registration/models/accident_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProvider {
  static late final Box<Map<dynamic, dynamic>> _accidentsBox;

  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    _accidentsBox = await Hive.openBox<Map<dynamic, dynamic>>('accidents');
  }

  static Stream<BoxEvent> accidentsStream() {
    return _accidentsBox.watch();
  }

  static List<AccidentModel> getAccidents() {
    final maps = _accidentsBox.values.toList();
    return maps.map((map) => AccidentModel.fromMap(map)).toList();
  }

  static Future<int> saveAccident(AccidentModel model) {
    return _accidentsBox.add(model.toJson());
  }

  static Future<void> deleteAccident(int index) {
    return _accidentsBox.deleteAt(index);
  }
}
