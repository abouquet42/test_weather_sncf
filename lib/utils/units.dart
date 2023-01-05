import 'package:weather_test_sncf/core/enums/unit_temp.dart';

String getUnitString(UnitTemp unit) {
  switch(unit) {
    case UnitTemp.celsius:
      return 'metric';
    case UnitTemp.kelvin:
      return 'standard';
    case UnitTemp.fahrenheit:
      return 'imperial';
  }
}

String getUnit(UnitTemp unit) {
  switch(unit) {
    case UnitTemp.celsius:
      return 'C';
    case UnitTemp.kelvin:
      return 'K';
    case UnitTemp.fahrenheit:
      return 'F';
  }
}