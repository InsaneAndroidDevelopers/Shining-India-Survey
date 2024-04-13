import 'package:hive/hive.dart';
import 'package:shining_india_survey/global/values/string_constants.dart';

class HiveDbHelper {

  static Future openBox() async {
    await Hive.openBox(StringsConstants.QUESTION_COLLECTION);
  }

  static Box getBox(){
    var box = Hive.box(StringsConstants.QUESTION_COLLECTION);
    return box;
  }

  static Future closeBox() async {
    await Hive.close();
  }

  static Future insertData(Map<String, String> questionWithIds) async {
    var box = Hive.box(StringsConstants.QUESTION_COLLECTION);
    await box.putAll(questionWithIds);
  }

  static Future deleteBox() async {
    var box = getBox();
    await box.clear();
  }
}