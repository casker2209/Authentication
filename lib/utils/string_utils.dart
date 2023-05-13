import 'dart:math';

class StringUtils{
  static String randomString() {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return  String.fromCharCodes(Iterable.generate(
        15, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}