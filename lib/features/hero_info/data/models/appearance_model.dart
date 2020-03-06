import 'package:meta/meta.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/appearance.dart';

///this class extends Appearance inheriting all its attributes and
///we create a constructor that receives matching data types for the attributes
///on the father class in order to just use those attributes as our class hasn't
///new attributes its a representation on the data layer of our entity on domain
class AppearanceModel extends Appearance {
  AppearanceModel({
    @required final String gender,
    @required final String race,
    @required final List<String> height,
    @required final List<String> weight,
    @required final String eyeColor,
    @required final String hairColor,
  }) : super(
          gender: gender,
          race: race,
          height: height,
          weight: weight,
          eyeColor: eyeColor,
          hairColor: hairColor,
        );
  factory AppearanceModel.fromJson(Map<String, dynamic> json) {
    return AppearanceModel(
      gender: json['gender'],
      race: json['race'],
      height: json['height'].cast<String>(),
      weight: json['weight'].cast<String>(),
      eyeColor: json['eye-color'],
      hairColor: json['hair-color'],
    );
  }
}
