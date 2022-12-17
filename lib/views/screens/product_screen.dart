import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_paystack_api/models/product.dart';
import 'package:flutter_paystack_api/providers/global_providers.dart';
import 'package:flutter_paystack_api/utils/enums.dart';
import 'package:flutter_paystack_api/views/components/product_card.dart';
import 'package:flutter_paystack_api/views/screens/customer_screen.dart';
import 'package:flutter_paystack_api/views/screens/transaction_screen.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider).getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productPro = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Products",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.black38),
          ),
          PopupMenuButton<PopMenu>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => value == PopMenu.customers
                    ? const CustomerScreen()
                    : const TransactionScreen(),
              ),
            ),
            color: Colors.grey.shade100,
            itemBuilder: (context) {
              return List.generate(
                PopMenu.values.length,
                (index) {
                  final popMeun = PopMenu.values[index];
                  return PopupMenuItem(
                    value: popMeun,
                    child: Text(popMeun.name.toUpperCase()),
                  );
                },
              );
            },
          )
        ],
      ),
      body: productPro.status != ApiStatus.loading
          ? productPro.status == ApiStatus.loaded
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    final Product product = productPro.products[index];
                    return ProductCard(product: product);
                  },
                  itemCount: productPro.products.length,
                )
              : Center(
                  child: Text(
                    productPro.apiResponse.error?.toString() ??
                        "Unknown error occurred",
                  ),
                )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
