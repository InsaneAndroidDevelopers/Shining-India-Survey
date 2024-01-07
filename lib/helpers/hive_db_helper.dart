import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shining_india_survey/global/values/string_constants.dart';

class HiveDbHelper {

  static Future openBox() async {
    debugPrint('opening box');
    await Hive.openBox(StringsConstants.QUESTION_COLLECTION);
  }

  static Box getBox(){
    debugPrint('getting box');
    var box = Hive.box(StringsConstants.QUESTION_COLLECTION);
    return box;
  }

  static Future closeBox() async {
    debugPrint('closing box');
    await Hive.close();
  }

  static Future insertData(Map<String, String> questionWithIds) async {
    debugPrint('inserting data');
    var box = Hive.box(StringsConstants.QUESTION_COLLECTION);
    await box.putAll(questionWithIds);
  }

  static Future deleteBox() async {
    debugPrint('clearing box');
    var box = getBox();
    await box.clear();
  }
}