import 'package:flutter/material.dart';
import 'package:flutter_paystack_api/models/paystack_auth_response.dart';
import 'package:flutter_paystack_api/services/paystack_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends ConsumerWidget {
  // we need to get some info from customer and other like reference, amount, email
  final String reference;
  final String currency;
  final String email;
  final String amount;
  final Object? metadata;
  final Object? channel;
  final Function(Object?)
      onCompletedTransaction; // for notifying the user about the successful transaction
  final Function(Object?)
      onFailedTransaction; // For notifying user about the failed transaction

  const PaymentScreen({
    super.key,
    required this.reference,
    required this.currency,
    required this.email,
    required this.amount,
    this.metadata,
    this.channel,
    required this.onCompletedTransaction,
    required this.onFailedTransaction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Next is to send the info to Paystack to initialize and generate authorized transction url so we need async widget like FutureBuilder
    return FutureBuilder<PaystackAuthResponse>(
        // when the paystaack send back the result, we need the model to get authorized url for the transaction
        future: PaystackService().initializeTransaction(
          email: email,
          amount: amount,
          reference: reference,
          metadata: metadata,
        ),
        builder: (context, snapshot) {
          // before we start to render the url, we need webview package and sometimes user may leave the web page after either abandoning or completing the transaction so we will use WillPopScope widget
          return WillPopScope(
            onWillPop: () async {
              // we can use this way to verify if user has already completed or abandoned the web page
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.authorizationUrl != null) {
                PaystackService()
                    .verifyTransaction(
                      snapshot.data!.reference!,
                      onCompletedTransaction,
                      onFailedTransaction,
                    )
                    .then((value) => Navigator.of(context).pop());
                return false;
              }
              return true;
            },
            // next we need to render the url we received from Paystack
            // my dear subscriber and viwers i am sorry i did talk or speak because i am having a hearing impairment okay.
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Paystack Payment "),
                leading: IconButton(
                    onPressed: () {
                      // User may want to leave the web page with or without completing the transaction
                      // then we need to verify the transaction and notify the user of the transaction status
                      // it is advisable to use webhook flow because according to Paystack, event of the transaction may take longer than expected.
                      // it is just all and next tutorial we will learn how to really initialze the transaction.
                      // Please dont forget to subscribe to my channel if you have not done so already becuase
                      // it help motivate me keep making more tutorials for you guys.
                      //  See you soon bye!
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data!.authorizationUrl != null) {
                        PaystackService()
                            .verifyTransaction(
                              snapshot.data!.reference!,
                              onCompletedTransaction,
                              onFailedTransaction,
                            )
                            .then((value) => Navigator.of(context).pop());
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.close)),
              ),
              body: (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data!.authorizationUrl != null)
                  ? WebView(
                      initialUrl: snapshot.data!.authorizationUrl!,
                      javascriptMode: JavascriptMode.unrestricted,
                    )
                  : snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text("Here? : ${snapshot.error.toString()}"),
            ),
          );
        });
  }
}
