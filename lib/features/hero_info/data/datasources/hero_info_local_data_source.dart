import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';

abstract class HeroInfoLocalDataSource {
  /// Gets the cached [HeroModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<HeroModel> getLastHero();
  Future<void> cacheHero(HeroModel heroToCache);
}
