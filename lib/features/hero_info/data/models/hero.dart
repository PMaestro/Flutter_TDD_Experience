class Hero {
  String response;
  String id;
  String name;
  String gender;
  String race;
  List<String> height;
  List<String> weight;
  String eyeColor;
  String hairColor;

  Hero(
      {this.response,
      this.id,
      this.name,
      this.gender,
      this.race,
      this.height,
      this.weight,
      this.eyeColor,
      this.hairColor});

//  hero.fromJson(Map<String, dynamic> json) {
//    response = json['response'];
//    id = json['id'];
//    name = json['name'];
//    gender = json['gender'];
//    race = json['race'];
//    height = json['height'].cast<String>();
//    weight = json['weight'].cast<String>();
//    eyeColor = json['eye-color'];
//    hairColor = json['hair-color'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['response'] = this.response;
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['gender'] = this.gender;
//    data['race'] = this.race;
//    data['height'] = this.height;
//    data['weight'] = this.weight;
//    data['eye-color'] = this.eyeColor;
//    data['hair-color'] = this.hairColor;
//    return data;
//  }
}
