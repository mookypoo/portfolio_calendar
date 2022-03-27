import 'dart:ui';
import '../models/day_models.dart' show DateModel;

class Today {
  static final DateModel today = DateModel.today();
}

class MyColors {
  static const Color primary = const Color.fromRGBO(65, 105, 255, 1.0);
  static const Color secondary = const Color.fromRGBO(65, 105, 255, 0.6);
  static const Color bg = const Color.fromRGBO(204, 221, 255, 0.65);
  static const Color transpRed = const Color.fromRGBO(216, 31, 42, 0.3);
  static const Color red = const Color.fromRGBO(216, 31, 42, 1.0);
  static const Color transpBlack = const Color.fromRGBO(0, 0, 0, 0.3);
  static const Color black = const Color.fromRGBO(0, 0, 0, 1.0);
}

class EventColors {
  static const Color red = const Color.fromRGBO(224, 76, 76, 1.0);
  static const Color orange = const Color.fromRGBO(245, 155, 124, 1.0);
  static const Color yellow = const Color.fromRGBO(250, 253, 15, 1.0);
  static const Color green = const Color.fromRGBO(0, 255, 0, 1.0);
  static const Color blue = const Color.fromRGBO(65, 105, 255, 1.0);
  static const Color purple = const Color.fromRGBO(204, 169, 221, 1.0);

}