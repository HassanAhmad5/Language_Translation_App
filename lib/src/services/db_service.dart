import 'dart:io';
import 'package:all_language_translator/src/models/most_phrases.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../controller/speak_translate/speak_translate_cont.dart';

class DatabaseService {
  late Database _db;

  final SpeakTranslateController translateController = Get.put(SpeakTranslateController());

  initDatabase() async {

    _db = await openDatabase('assets/db_prahse.db');
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, "db_prahse.db");

    var exists = await databaseExists(path);

    if(!exists)
      {
        print("Create a new copy from assets");

        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {

        }

        ByteData data = await rootBundle.load(join("assets", "db_prahse.db"));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
      }

    _db = await openDatabase(path, readOnly: true);
  }

  Future<List<Map<String, String>>> getMostPhrasesWithTranslation(Function translateText) async {
    await initDatabase();

    // Fetch data from the database
    List<Map> list = await _db.rawQuery('SELECT * FROM MostPhrases WHERE catID = 2');

    // Temporary list to store translated phrases
    List<Map<String, String>> translatedPhrases = <Map<String, String>>[];

    for (var phraseMap in list) {
      // Convert the phrase data into a MostPhrases instance
      MostPhrases phrase = MostPhrases.fromJson(phraseMap as Map<String, dynamic>);


      // Translate the phrase text
      String translatedText = await translateText(phrase.phrases);


      // Add the translated phrase to the temporary list
      translatedPhrases.add({"text": phrase.phrases.toString(), "translatedText": translatedText});
    }

    return translatedPhrases;
  }


  dispose() {
    _db.close();
  }
}