import 'package:meta/meta.dart';
import 'package:tdd_studing/features/hero_info/data/models/appearance_model.dart';
import 'package:tdd_studing/features/hero_info/data/models/power_stats_model.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';

///this class extends Appearance inheriting all its attributes and
///we create a constructor that receives matching data types for the attributes
///on the father class in order to just use those attributes as our class hasn't
///new attributes its a representation on the data layer of our entity on domain
class HeroModel extends Hero {
  HeroModel({
    @required final String response,
    @required final String id,
    @required final String name,
    @required final PowerStatsModel powerStats,
    @required final AppearanceModel appearance,
    //todo find a way to get just the url from a simple query
    @required final String imageUrl,
  }) : super(
          response: response,
          id: id,
          name: name,
          powerstats: powerStats,
          appearance: appearance,
          imageUrl: imageUrl,
        );

  //the name on the json['name of the json file property']
  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      response: json['response'],
      id: json['id'],
      name: json['name'],
      powerStats: json['powerstats'] != null
          ? new PowerStatsModel.fromJson(json['powerstats'])
          : null,
      appearance: json['appearance'] != null
          ? new AppearanceModel.fromJson(json['appearance'])
          : null,
      imageUrl: json['imageUrl'],
    );
  }
}
