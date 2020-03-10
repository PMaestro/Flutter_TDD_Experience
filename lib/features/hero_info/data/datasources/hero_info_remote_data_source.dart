import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';

abstract class HeroInfoRemoteDataSource {
  /// Calls the https://superheroapi.com/api/2983597721691728/{character-id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Hero> getHero(String id);

  /// Calls the https://superheroapi.com/api/2983597721691728/{character-id} endpoint multiple times.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Hero> getRandomHero();
}
