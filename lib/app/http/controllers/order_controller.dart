import 'package:mycommmerce/app/models/order.dart';
import 'package:mycommmerce/app/models/order_item.dart';
import 'package:vania/vania.dart';

class OrderController extends Controller {
  Future<Response> index() async {
    try {
      var data = await Order()
          .query()
          .join('orderitems', 'orders.order_num', '=', 'orderitems.order_num')
          .join('customers', 'orders.cust_id', '=', 'customers.cust_id')
          .get();

      return Response.json(data);
    } catch (e) {
      print(e);
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  Future<Response> show(String orderNum) async {
    try {
      var data = await Order()
          .query()
          .where('orders.order_num', '=', orderNum)
          .join('orderitems', 'orders.order_num', '=', 'orderitems.order_num')
          .join('customers', 'orders.cust_id', '=', 'customers.cust_id')
          .get();

      return Response.json(data);
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  Future<Response> store(Request request) async {
    try {
      var custId = request.input('cust_id');
      var orderItems = request.input('order_items');

      var orderNum = Order().generateId();
      await Order().query().insert({
        'order_num': orderNum,
        'order_date': DateTime.now().toIso8601String(),
        'cust_id': custId,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      List<Map<String, dynamic>> insertedItems = [];
      for (var item in orderItems) {
        var prodId = item['prod_id'];
        var quantity = item['quantity'];
        var size = item['size'];

        var orderItemId = OrderItem().generateId();
        await OrderItem().query().insert({
          'order_item': orderItemId,
          'order_num': orderNum,
          'prod_id': prodId,
          'quantity': quantity,
          'size': size,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        var insertedItem = {
          'order_item': orderItemId,
          'order_num': orderNum,
          'prod_id': prodId,
          'quantity': quantity,
          'size': size,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        };
        insertedItems.add(insertedItem);
      }

      return Response.json(
          {'status': 'success', 'message': 'Berhasil menambahkan order'});
    } catch (e) {
      print(e);
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  Future<Response> destroy(String orderNum) async {
    try {
      await OrderItem().query().where('order_num', '=', orderNum).delete();

      await Order().query().where('order_num', '=', orderNum).delete();

      return Response.json({
        'status': 'success',
        'message': 'Berhasil menghapus order',
      });
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }
}

final OrderController orderController = OrderController();
