import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesKey {
  ranking,
  ;
}

typedef Score = (int seconds, bool newRecord, bool rankedIn, String createdAt);

class SharedPreferencesService {
  factory SharedPreferencesService() {
    return _instance;
  }
  SharedPreferencesService._internal();
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  static SharedPreferences? _preferences;

  Future<void> getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  List<Score> getRanking() {
    // 保存されたJSON文字列を取得
    final jsonString =
        _preferences?.getStringList(SharedPreferencesKey.ranking.name) ?? [];

    // JSON文字列をデコードしてリストに変換
    return jsonString.map((e) {
      final decoded = jsonDecode(e) as Map<String, dynamic>;
      return (
        decoded['seconds'] as int,
        decoded['newRecord'] as bool,
        decoded['rankedIn'] as bool,
        decoded['createdAt'] as String
      );
    }).toList();
  }

  Future<void> saveRanking(
    List<Score> data,
  ) async {
    // データをJSON文字列に変換
    final rankingDataList = data
        .map(
          (e) => jsonEncode(
            {
              'seconds': e.$1,
              'newRecord': e.$2,
              'rankedIn': e.$3,
              'createdAt': e.$3,
            },
          ),
        )
        .toList();

    // JSON文字列をSharedPreferencesに保存
    await _preferences?.setStringList(
      SharedPreferencesKey.ranking.name,
      rankingDataList,
    );
  }
}
