import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_studing/features/hero_info/data/models/power_stats_model.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/power_stats.dart';

void main() {
  final tPowerStats = PowerStatsModel(
    intelligence: '100',
    power: '47',
    speed: '27',
    strength: '26',
    combat: '100',
    durability: '50',
  );
  test(
    'should be a subclass of Hero entity',
    () async {
      //arrange

      //act

      //assert
      expect(tPowerStats, isA<PowerStats>());
    },
  );
}
