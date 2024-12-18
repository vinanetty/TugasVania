import 'package:mycommmerce/app/models/product.dart';
import 'package:mycommmerce/app/models/vendor.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {
  Future<Response> index() async {
    try {
      var data = await Vendor().query().get();
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
      var state = request.input('state');
      var zip = request.input('zip');
      var country = request.input('country');

      var vendId = Vendor().generateId();
      await Vendor().query().insert({
        'vend_id': vendId,
        'vend_name': name,
        'vend_address': address,
        'vend_kota': kota,
        'vend_state': state,
        'vend_zip': zip,
        'vend_country': country,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      return Response.json({
        'status': 'success',
        'message': 'Berhasil menambahkan data vendor',
      });
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
      var vendor = await Vendor().query().where('vend_id', '=', id).first();
      if (vendor == null) {
        return Response.json({
          'status': 'error',
          'message': 'Data vendor tidak ditemukan',
        });
      }
      var products = await Product().query().where('vend_id', '=', id).get();
      vendor['products'] = products;
      return Response.json(vendor);
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
      var state = request.input('state');
      var zip = request.input('zip');
      var country = request.input('country');

      await Vendor().query().where('vend_id', '=', id).update({
        'vend_name': name,
        'vend_address': address,
        'vend_kota': kota,
        'vend_state': state,
        'vend_zip': zip,
        'vend_country': country,
        'updated_at': DateTime.now().toIso8601String(),
      });

      return Response.json({
        'status': 'success',
        'message': 'Berhasil memperbarui data vendor',
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
      var data = await Vendor().query().where('vend_id', '=', id).first();

      await Vendor().query().where('vend_id', '=', id).delete();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil menghapus data vendor',
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

final VendorController vendorController = VendorController();
