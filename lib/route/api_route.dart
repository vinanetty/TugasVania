import 'package:mycommmerce/app/http/controllers/customer_controller.dart';
import 'package:mycommmerce/app/http/controllers/order_controller.dart';
import 'package:mycommmerce/app/http/controllers/product_controller.dart';
import 'package:mycommmerce/app/http/controllers/product_note_controller.dart';
import 'package:mycommmerce/app/http/controllers/vendor_controller.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    Router.basePrefix('api');

    Router.group(() {
      Router.get('/', customerController.index);
      Router.post('/', customerController.store);
      Router.get('/{id}', customerController.show);
      Router.put('/{id}', customerController.update);
      Router.delete('/{id}', customerController.destroy);
    }, prefix: '/customers');

    Router.group(() {
      Router.get('/', vendorController.index);
      Router.post('/', vendorController.store);
      Router.get('/{id}', vendorController.show);
      Router.put('/{id}', vendorController.update);
      Router.delete('/{id}', vendorController.destroy);
    }, prefix: '/vendors');

    Router.group(() {
      Router.get('/', productController.index);
      Router.post('/', productController.store);
      Router.get('/{id}', productController.show);
      Router.put('/{id}', productController.update);
      Router.delete('/{id}', productController.destroy);
    }, prefix: '/products');

    Router.group(() {
      Router.get('/', productNoteController.index);
      Router.post('/', productNoteController.store);
      Router.get('/{id}', productNoteController.show);
      Router.put('/{id}', productNoteController.update);
      Router.delete('/{id}', productNoteController.destroy);
    }, prefix: '/notes');

    Router.group(() {
      Router.get('/', orderController.index);
      Router.post('/', orderController.store);
      Router.get('/{id}', orderController.show);
      Router.delete('/{id}', orderController.destroy);
    }, prefix: '/orders');
  }
}
