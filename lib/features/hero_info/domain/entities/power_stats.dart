import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PowerStats extends Equatable {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  PowerStats({
    @required this.intelligence,
    @required this.strength,
    @required this.speed,
    @required this.durability,
    @required this.power,
    @required this.combat,
  }) : super([
          intelligence,
          strength,
          speed,
          durability,
          power,
          combat,
        ]);

  toJson() {}
}
