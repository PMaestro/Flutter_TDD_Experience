import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/appearance.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/power_stats.dart';
import 'package:tdd_studing/features/hero_info/domain/repositories/hero_info_repository.dart';
import 'package:tdd_studing/features/hero_info/domain/usecases/get_list_of_heroes.dart';

class MockHeroInfoRepository extends Mock implements HeroInfoRepository {}

void main() {
  GetListOfHeroes usecase;
  MockHeroInfoRepository mockHeroInfoRepository;

  setUp(() {
    mockHeroInfoRepository = MockHeroInfoRepository();
    usecase = GetListOfHeroes(mockHeroInfoRepository);
  });

  final tHeroes = [
    Hero(
      response: 'success',
      id: '70',
      name: 'Batman',
      imageUrl:
          'httpss://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
      appearance: Appearance(
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
      powerStats: PowerStats(
        intelligence: '100',
        power: '47',
        speed: '27',
        strength: '26',
        combat: '100',
        durability: '50',
      ),
    ),
  ];

  test(
    'should get a list of heroes from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockHeroInfoRepository.listHeroes())
          .thenAnswer((_) async => Right(tHeroes));
      final result = await usecase(NoParams());
      // The "act" phase of the test. Call the not-yet-existent method.
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tHeroes));
      // Verify that the method has been called on the Repository
      verify(mockHeroInfoRepository.listHeroes());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockHeroInfoRepository);
    },
  );
}
