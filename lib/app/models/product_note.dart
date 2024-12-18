import 'dart:math';
import 'package:vania/vania.dart';

class ProductNote extends Model {
  ProductNote() {
    super.table('productnotes');
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
