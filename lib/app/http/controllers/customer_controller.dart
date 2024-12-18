import 'package:mycommmerce/app/models/customer.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {
  Future<Response> index() async {
    try {
      var data = await Customer().query().get();
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
      var name = request.input('name');
      var address = request.input('address');
      var kota = request.input('kota');
      var zip = request.input('zip');
      var country = request.input('country');
      var telp = request.input('telp');

      var custId = Customer().generateId();
      await Customer().query().insert({
        'cust_id': custId,
        'cust_name': name,
        'cust_address': address,
        'cust_city': kota,
        'cust_zip': zip,
        'cust_country': country,
        'cust_telp': telp,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      var data = await Customer().query().where('cust_id', '=', custId).first();
      return Response.json(data);
    } catch (e) {
      print(e);
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  Future<Response> show(String id) async {
    try {
      var customer = await Customer().query().where('cust_id', '=', id).first();

      return Response.json(customer);
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  Future<Response> update(Request request, String id) async {
    try {
      var name = request.input('name');
      var address = request.input('address');
      var kota = request.input('kota');
      var zip = request.input('zip');
      var country = request.input('country');
      var telp = request.input('telp');

      await Customer().query().where('cust_id', '=', id).update({
        'cust_name': name,
        'cust_address': address,
        'cust_city': kota,
        'cust_zip': zip,
        'cust_country': country,
        'cust_telp': telp,
        'updated_at': DateTime.now().toIso8601String(),
      });
      var data = await Customer().query().where('cust_id', '=', id).first();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil mengupdate data customer',
        'data': data
      });
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  Future<Response> destroy(String id) async {
    try {
      var data = await Customer().query().where('cust_id', '=', id).first();

      await Customer().query().where('cust_id', '=', id).delete();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil menghapus data customer',
        'data': data
      });
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }
}

final CustomerController customerController = CustomerController();
