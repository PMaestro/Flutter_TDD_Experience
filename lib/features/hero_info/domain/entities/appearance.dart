import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Appearance extends Equatable {
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;

  Appearance({
    @required this.gender,
    @required this.race,
    @required this.height,
    @required this.weight,
    @required this.eyeColor,
    @required this.hairColor,
  });
}
