import 'package:flutter/foundation.dart';
import 'package:flutter_paystack_api/models/api_response.dart';
import 'package:flutter_paystack_api/models/product.dart';
import 'package:flutter_paystack_api/services/api_service.dart';
import 'package:flutter_paystack_api/utils/constants.dart';
import 'package:flutter_paystack_api/utils/enums.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final List<Product> _products = [];
  List<Product> get products => _products;
  ApiResponse _apiResponse = ApiResponse();
  ApiResponse get apiResponse => _apiResponse;

  ApiStatus _status = ApiStatus.unload;
  ApiStatus get status => _status;

  _setApiStatus(ApiStatus value) {
    _status = value;
    notifyListeners();
  }

  Future getProducts() async {
    _products.clear();
    _setApiStatus(ApiStatus.loading);
    try {
      _apiResponse = await _apiService.get(url: Constants.products);
      if (_apiResponse.statusCode != null && _apiResponse.data != null) {
        if (_apiResponse.statusCode == 200) {
          final rawProducts = _apiResponse.data as List;
          if (rawProducts.isNotEmpty) {
            final mappedProducts = rawProducts
                .map((p) => Product.fromJson(p as Map<String, dynamic>))
                .toList();
            _products.addAll(mappedProducts);
          }
          _setApiStatus(ApiStatus.loaded);
        } else {
          _setApiStatus(ApiStatus.error);
        }
      } else {
        _setApiStatus(ApiStatus.error);
      }
    } catch (e) {
      debugPrint(e.toString());
      _apiResponse.error = e.toString();
      _setApiStatus(ApiStatus.error);
    }
    notifyListeners();
  }
}
