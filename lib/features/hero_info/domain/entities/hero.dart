import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/appearance.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/power_stats.dart';

/// its just the hero from the https://superheroapi.com
/// but we are just fetching powerstats, appearance and image
/// https://superheroapi.com/api/2983597721691728/character-id
class Hero extends Equatable {
  final String response;
  final String id;
  final String name;
  final PowerStats powerstats;
  final Appearance appearance;
  //todo find a way to get just the url from a simple query
  final String imageUrl;

  Hero({
    @required this.response,
    @required this.id,
    @required this.name,
    @required this.powerstats,
    @required this.appearance,
    @required this.imageUrl,
  }) : super([
          response,
          id,
          name,
          powerstats,
          appearance,
          imageUrl,
        ]);
}
