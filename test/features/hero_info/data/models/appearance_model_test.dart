import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_studing/features/hero_info/data/models/appearance_model.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/appearance.dart';

void main() {
  final tAppearence = AppearanceModel(
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
    ],
  );
  test(
    'should be a subclass of Hero entity',
    () async {
      //arrange

      //act

      //assert
      expect(tAppearence, isA<Appearance>());
    },
  );
}
