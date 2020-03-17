import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_studing/core/error/exceptions.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_remote_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  HeroInfoRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = HeroInfoRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('hero.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void testGetHeroFromWeb(String heroId, HeroModel tHeroModelToCompare) async {
    if (heroId != '') {
      final result = await dataSource.getHero(heroId);
      expect(result, equals(tHeroModelToCompare));
    } else {
      final result = await dataSource.getRandomHero();
      expect(result, equals(tHeroModelToCompare));
    }
  }

  void testGetHeroFromWebFail(String heroId) {
    if (heroId != '') {
      final call = dataSource.getHero;
      //assert
      expect(() => call(heroId), throwsA(TypeMatcher<ServerException>()));
    } else {
      final call = dataSource.getRandomHero;
      //assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    }
  }

  group('getheroInfo', () {
    final heroId = '70';
    final tHeroModel = HeroModel.fromJson(json.decode(fixture('hero.json')));

    test('''should perform a GET request on a URL with heroId being 
    the endpoint and with application/json header''', () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      dataSource.getHero(heroId);
      //assert
      verify(mockHttpClient.get(
        'https://superheroapi.com/api/2983597721691728/$heroId',
        headers: {
          'Content-Type:': 'application/json',
        },
      ));
    });

    test('should return HeroInfo when the response code is 200(success)',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      testGetHeroFromWeb(heroId, tHeroModel);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      testGetHeroFromWebFail(heroId);
    });
  });

  group('getRamdonHeroInfo', () {
    final tHeroModel = HeroModel.fromJson(json.decode(fixture('hero.json')));
    //todo Check why this method get error and how should i verify if its correct
    test('''should perform a GET request on a URL with heroId being 
    the endpoint and with application/json header''', () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      dataSource.getRandomHero();
      //assert
      String randomId = (Random().nextInt(721)).toString();

      verify(mockHttpClient.get(
        'https://superheroapi.com/api/2983597721691728/$randomId',
        headers: {
          'Content-Type:': 'application/json',
        },
      ));
    });

    test('should return HeroInfo when the response code is 200(success)',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      testGetHeroFromWeb('', tHeroModel);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      testGetHeroFromWebFail('');
    });
  });
}
