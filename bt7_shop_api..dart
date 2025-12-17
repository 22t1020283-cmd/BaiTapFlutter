import 'package:dio/dio.dart';
import 'bt7_shop_model.dart'; // Import file model cùng thư mục

class Api {
  Future<List<Product>> getAllProducts() async {
    var dio = Dio();
    try {
      var response = await dio.request('https://fakestoreapi.com/products');
      List<Product> listProduct = [];
      if (response.statusCode == 200) {
        List data = response.data;
        listProduct = data.map((x) => Product.fromJson(x)).toList();
      } else {
        print('Lỗi kết nối: ${response.statusCode}');
      }
      return listProduct;
    } catch (e) {
      print('Lỗi API: $e');
      throw e; // Ném lỗi để UI bắt được
    }
  }
}
