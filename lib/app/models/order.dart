import 'dart:math';
import 'package:vania/vania.dart';

class Order extends Model {
  Order() {
    super.table('orders');
  }
  String generateId() {
    const availableChars = '1234567890';
    final random = Random();
    final randomString = StringBuffer();

    for (int i = 0; i < 5; i++) {
      final index = random.nextInt(availableChars.length);
      randomString.write(availableChars[index]);
    }

    return randomString.toString();
  }
}
