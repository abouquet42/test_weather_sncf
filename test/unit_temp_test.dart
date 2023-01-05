// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_test_sncf/core/enums/unit_temp.dart';
import 'package:weather_test_sncf/utils/units.dart';

void main() {
  group('Get unit', () {
    test('Celsius', () {
      final String unitStr = getUnitString(UnitTemp.celsius);
      expect(unitStr, 'metric');
      final String unit = getUnit(UnitTemp.celsius);
      expect(unit, 'C');
    });

    test('Kelvin', () {
      final String unitStr = getUnitString(UnitTemp.kelvin);
      expect(unitStr, 'standard');
      final String unitKelvin = getUnit(UnitTemp.kelvin);
      expect(unitKelvin, 'K');
    });

    test('Fahrenheit', () {
      final String unitStr = getUnitString(UnitTemp.fahrenheit);
      expect(unitStr, 'imperial');
      final String unitFahrenheit = getUnit(UnitTemp.fahrenheit);
      expect(unitFahrenheit, 'F');
    });
  });
}
