import 'package:flutter_paystack_api/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider =
    ChangeNotifierProvider<ProductProvider>((ref) => ProductProvider());
