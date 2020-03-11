import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:tdd_studing/core/error/exceptions.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';

abstract class HeroInfoRemoteDataSource {
  /// Calls the https://superheroapi.com/api/2983597721691728/{character-id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<HeroModel> getHero(String id);

  /// Calls the https://superheroapi.com/api/2983597721691728/{character-id} endpoint multiple times.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<HeroModel> getRandomHero();
}

class HeroInfoRemoteDataSourceImpl implements HeroInfoRemoteDataSource {
  final http.Client client;

  HeroInfoRemoteDataSourceImpl({@required this.client});

  getConcreteOrRandomHeroInfo(String id) async {
    final response = await client.get(
      'https://superheroapi.com/api/2983597721691728/$id',
      headers: {
        'Content-Type:': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return HeroModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Error during comunication');
    }
  }

  @override
  Future<HeroModel> getHero(String id) async {
    return await getConcreteOrRandomHeroInfo(id);
  }

  @override
  Future<HeroModel> getRandomHero() async {
    int randomId = Random().nextInt(731);
    return await getConcreteOrRandomHeroInfo(randomId.toString());
  }
}
