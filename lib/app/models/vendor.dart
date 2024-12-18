import 'dart:math';
import 'package:vania/vania.dart';

class Vendor extends Model {
  Vendor() {
    super.table('vendors');
  }
  String generateId() {
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final random = Random();
    final randomString = StringBuffer();

    for (int i = 0; i < 5; i++) {
      final index = random.nextInt(availableChars.length);
      randomString.write(availableChars[index]);
    }

    return randomString.toString();
  }
}
