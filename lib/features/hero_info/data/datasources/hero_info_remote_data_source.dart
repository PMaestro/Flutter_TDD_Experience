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
  final _url = 'https://superheroapi.com/api/2983597721691728/';
  HeroInfoRemoteDataSourceImpl({@required this.client});

  getConcreteOrRandomHeroInfo(String id, String url) async {
    final response = await client.get(
      '$_url$id',
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
    return await getConcreteOrRandomHeroInfo(id, _url);
  }

  @override
  Future<HeroModel> getRandomHero() async {
    int randomId = Random().nextInt(731);
    return await getConcreteOrRandomHeroInfo(randomId.toString(), _url);
  }
}
