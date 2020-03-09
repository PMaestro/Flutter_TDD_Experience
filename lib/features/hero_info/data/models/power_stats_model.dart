import 'package:meta/meta.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/power_stats.dart';

///this class extends Appearance inheriting all its attributes and
///we create a constructor that receives matching data types for the attributes
///on the father class in order to just use those attributes as our class hasn't
///new attributes its a representation on the data layer of our entity on domain
///new attributes its a representation on the data layer of our entity on domain
class PowerStatsModel extends PowerStats {
  PowerStatsModel({
    @required final String intelligence,
    @required final String strength,
    @required final String speed,
    @required final String durability,
    @required final String power,
    @required final String combat,
  }) : super(
          intelligence: intelligence,
          strength: strength,
          speed: speed,
          durability: durability,
          power: power,
          combat: combat,
        );

  factory PowerStatsModel.fromJson(Map<String, dynamic> json) {
    return PowerStatsModel(
      intelligence: json['intelligence'],
      strength: json['strength'],
      speed: json['speed'],
      durability: json['durability'],
      power: json['power'],
      combat: json['combat'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'intelligence': intelligence,
      'strength': strength,
      'speed': speed,
      'durability': durability,
      'power': power,
      'combat': combat,
    };
  }
}
