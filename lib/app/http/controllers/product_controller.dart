import 'package:mycommmerce/app/models/product.dart';
import 'package:mycommmerce/app/models/product_note.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> index() async {
    try {
      var data = await Product().query().get();
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
      var vendId = request.input('vend_id');
      var name = request.input('name');
      var price = request.input('price');
      var desc = request.input('desc');

      var prodId = Product().generateId();
      await Product().query().insert({
        'prod_id': prodId,
        'vend_id': vendId,
        'prod_name': name,
        'prod_price': price,
        'prod_desc': desc,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      var data = await Product().query().where('prod_id', '=', prodId).first();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil menambahkan data produk',
        'data': data
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
      var product = await Product()
          .query()
          .join('vendors', 'products.vend_id', '=', 'vendors.vend_id')
          .select([
            'products.*',
            'vendors.vend_name as vendor_name',
            'vendors.vend_address as vendor_address'
          ])
          .where('prod_id', '=', id)
          .first();
      if (product == null) {
        return Response.json({
          'status': 'error',
          'message': 'Data produk tidak ditemukan',
        });
      }
      var productNotes =
          await ProductNote().query().where("prod_id", "=", id).get();
      return Response.json({
        'prod_id': product['prod_id'],
        'name': product['prod_name'],
        'price': product['prod_price'],
        'desc': product['prod_desc'],
        'vendor': {
          'vend_id': product['vend_id'],
          'name': product['vendor_name'],
          'address': product['vendor_address']
        },
        'product_notes': productNotes
      });
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  Future<Response> update(Request request, String id) async {
    try {
      var vendId = request.input('vend_id');
      var name = request.input('name');
      var price = request.input('price');
      var desc = request.input('desc');

      await Product().query().where('prod_id', '=', id).update({
        'vend_id': vendId,
        'prod_name': name,
        'prod_price': price,
        'prod_desc': desc,
        'updated_at': DateTime.now().toIso8601String(),
      });

      var data = await Product().query().where('prod_id', '=', id).first();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil memperbarui data produk',
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
      var data = await Product().query().where('prod_id', '=', id).first();

      await Product().query().where('prod_id', '=', id).delete();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil menghapus data produk',
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

final ProductController productController = ProductController();
