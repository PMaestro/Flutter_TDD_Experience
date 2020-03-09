import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_studing/core/error/exceptions.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/platform/network_info.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_local_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_remote_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/models/appearance_model.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';
import 'package:tdd_studing/features/hero_info/data/models/power_stats_model.dart';
import 'package:tdd_studing/features/hero_info/data/repositories/hero_info_repository_imp.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';

class MockRemoteDataSource extends Mock implements HeroInfoRemoteDataSource {}

class MockLocalDataSource extends Mock implements HeroInfoLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  HeroInfoRepositoryImpl repository;

  MockRemoteDataSource mockRemoteDataSource;

  MockLocalDataSource mockLocalDataSource;

  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = HeroInfoRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getHeroInfo', () {
    final tId = '70';

    final tHeroModel = HeroModel(
      response: 'success',
      id: '70',
      name: 'Batman',
      imageUrl:
          'httpss://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
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

    final Hero tHero = tHeroModel;

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getHero(tId);

      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successeful',
          () async {
        //arrange
        when(mockRemoteDataSource.getHero(any))
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getHero(tId);

        //assert
        verify(mockRemoteDataSource.getHero(tId));
        expect(result, equals(Right(tHero)));
      });

      test(
          'should cache the data localy when the call to remote data source is successeful',
          () async {
        //arrange
        when(mockRemoteDataSource.getHero(any))
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getHero(tId);

        //assert
        verify(mockRemoteDataSource.getHero(tId));
        verify(mockLocalDataSource.cacheHero(tHeroModel));
      });

      test(
          'should return server Failure when the call to remote data source is unsuccesseful',
          () async {
        //arrange
        when(mockRemoteDataSource.getHero(any)).thenThrow(
            ServerException('Error during comunication with server'));
        //act
        final result = await repository.getHero(tId);

        //assert
        verify(mockRemoteDataSource.getHero(tId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}