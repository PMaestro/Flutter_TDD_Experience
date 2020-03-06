import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_studing/features/hero_info/data/models/appearance_model.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';
import 'package:tdd_studing/features/hero_info/data/models/power_stats_model.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tHeroModel = HeroModel(
    response: 'success',
    id: "70",
    name: 'Batman',
    imageUrl: 'httpss://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
    appearance: AppearanceModel(
        eyeColor: 'blue',
        hairColor: 'black',
        race: 'Human',
        gender: 'Male',
        height: [
          "210 lb",
          "95 kg",
        ],
        weight: [
          "6'2",
          "188 cm",
        ]),
    powerStats: PowerStatsModel(
      intelligence: '100',
      power: '47',
      speed: '27',
      strength: '26',
      combat: '100',
      durability: '50',
    ),
  );

  test(
    'should be a subclass of Hero entity',
    () async {
      //arrange

      //act

      //assert
      expect(tHeroModel, isA<Hero>());
    },
  );

  group('fromJson', () {
    test(
        'should return a valid model when the JSON Hero is an hero with powerStats and Appearence',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('hero.json'));
      //act
      final result = HeroModel.fromJson(jsonMap);
      //assert
      expect(result, tHeroModel);
    });
  });
}
