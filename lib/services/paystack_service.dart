import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_paystack_api/models/api_response.dart';
import 'package:flutter_paystack_api/models/paystack_auth_response.dart';
import 'package:flutter_paystack_api/models/transaction.dart';
import 'package:flutter_paystack_api/services/api_service.dart';
import 'package:flutter_paystack_api/utils/constants.dart';

class PaystackService {
  final ApiService _apiService = ApiService();

  // Initialize Transaction
  Future<PaystackAuthResponse> initializeTransaction({
    required String email,
    required String amount,
    String currency = "GHS",
    required String reference,
    List<String> channels = const ["card", "mobile_money"],
    Object? metadata,
  }) async {
    ApiResponse response;
    try {
      response = await _apiService.post(
        url: Constants.initializeTransaction,
        data: jsonEncode({
          "email": email,
          "amount": amount,
          "reference": reference,
          "currency": currency,
          "metadata": metadata,
          "channels": channels,
        }),
      );

      if (response.statusCode == 200) {
        return PaystackAuthResponse.fromJson(
            response.data as Map<String, String>);
      } else {
        throw Exception(response.error.toString());
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Exception("Error: $e");
    }
  }

  // Verify Transaction after Customer makes payment
  Future verifyTransaction(
    String reference,
    Function(Object) onSuccessfulTransaction,
    Function(Object) onFailedTransaction,
  ) async {
    ApiResponse response;
    try {
      response =
          await _apiService.get(url: Constants.verifyTransaction(reference));
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data["gateway_response"] == "Successful") {
          // notify the user why the transaction was successful
          onSuccessfulTransaction(data);
        } else {
          // Also notify the user why the transaction was failed
          onFailedTransaction(data);
        }
      } else {
        // notify the user why the transaction was failed
        onFailedTransaction({
          "message": "Transaction failed",
        });
      }
    } on Exception catch (e) {
      onFailedTransaction({
        "message": e.toString(),
      });
    }
  }

  // Get lists of transactions
  Future<List<Transaction>> listTransactions() async {
    ApiResponse response;
    try {
      response = await _apiService.get(url: Constants.listTransactions);
      if (response.statusCode == 200) {
        final data = response.data as List;
        if (data.isEmpty) return [];
        return data
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
