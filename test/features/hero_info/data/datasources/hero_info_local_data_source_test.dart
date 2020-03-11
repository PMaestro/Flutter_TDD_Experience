import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_studing/core/error/exceptions.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_local_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  HeroInfoLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        HeroInfoLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastHeroInfo', () {
    final tHeroModel = HeroModel.fromJson(json.decode(fixture('hero.json')));
    test(
        'should return HeroInfo from SharedPreferences when there is one in the chache',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('hero.json'));

      final result = await dataSource.getLastHero();

      verify(mockSharedPreferences.getString(CACHED_HERO_INFO));
      expect(result, equals(tHeroModel));
    });

    test('should throw a CacheExeption when there is not a cached value',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSource.getLastHero;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
}
