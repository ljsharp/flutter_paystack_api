import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_paystack_api/views/screens/product_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PaystackApiApp(),
    ),
  );
}

class PaystackApiApp extends StatelessWidget {
  const PaystackApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paystack API',
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: const ProductScreen(),
    );
  }
}
