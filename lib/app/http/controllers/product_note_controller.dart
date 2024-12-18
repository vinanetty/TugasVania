import 'package:mycommmerce/app/models/product_note.dart';
import 'package:vania/vania.dart';

class ProductNoteController extends Controller {
  // Index: Menampilkan semua catatan produk
  Future<Response> index() async {
    try {
      var data = await ProductNote().query().get();
      return Response.json(data);
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  // Store: Menambahkan catatan untuk produk
  Future<Response> store(Request request) async {
    try {
      var prodId = request.input('prod_id');
      var noteText = request.input('note_text');

      var noteId = ProductNote().generateId();
      await ProductNote().query().insert({
        'note_id': noteId,
        'prod_id': prodId,
        'note_date': DateTime.now().toIso8601String(),
        'note_text': noteText,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Ambil data catatan yang baru saja disimpan
      var data =
          await ProductNote().query().where('note_id', '=', noteId).first();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil menambahkan data catatan produk',
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

  // Show: Menampilkan catatan produk berdasarkan ID
  Future<Response> show(String id) async {
    try {
      var note = await ProductNote().query().where('note_id', '=', id).first();

      return Response.json({'status': 'success', 'data': note});
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }

  // Update: Memperbarui catatan produk
  Future<Response> update(Request request, String id) async {
    try {
      var prodId = request.input('prod_id');
      var noteText = request.input('note_text');

      await ProductNote().query().where('note_id', '=', id).update({
        'prod_id': prodId,
        'note_text': noteText,
        'updated_at': DateTime.now().toIso8601String(),
      });

      var data = await ProductNote().query().where('note_id', '=', id).first();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil memperbarui data catatan produk',
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
      await ProductNote().query().where('note_id', '=', id).delete();
      return Response.json({
        'status': 'success',
        'message': 'Berhasil menghapus data catatan produk',
      });
    } catch (e) {
      return Response.json({
        'status': 'error',
        'message': 'Terjadi kesalahan, silahkan coba lagi',
      }, 500);
    }
  }
}

final ProductNoteController productNoteController = ProductNoteController();
