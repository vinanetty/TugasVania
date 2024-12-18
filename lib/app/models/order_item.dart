import 'dart:math';
import 'package:vania/vania.dart';

class OrderItem extends Model {
  OrderItem() {
    super.table('orderitems');
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
