import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Powerstats extends Equatable {
  final int intelligence;
  final int strength;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  Powerstats({
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
}
