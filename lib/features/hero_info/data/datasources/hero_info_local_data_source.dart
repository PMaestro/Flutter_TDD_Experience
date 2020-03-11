import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';

abstract class HeroInfoLocalDataSource {
  /// Gets the cached [HeroModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<HeroModel> getLastHero();
  Future<void> cacheHero(HeroModel heroToCache);
}

class HeroInfoLocalDataSourceImpl implements HeroInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  HeroInfoLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheHero(HeroModel heroToCache) {
    // TODO: implement cacheHero
    return null;
  }

  @override
  Future<HeroModel> getLastHero() {
    final jsonString = sharedPreferences.getString('CACHED_HERO_INFO');
    return Future.value(HeroModel.fromJson(json.decode(jsonString)));
  }
}
