class Constants {
  // Paystack Api Endpoints - Customer
  static const String createCustomer = "https://api.paystack.co/customer";
  static const String listCustomers = "https://api.paystack.co/customer";
  static String fetchCustomer(String emailOrCode) =>
      "https://api.paystack.co/customer/$emailOrCode";
  static String updateCustomer(String code) =>
      "https://api.paystack.co/customer/$code";

  // Paystack Api Endpoints - Transaction
  static const initializeTransaction =
      "https://api.paystack.co/transaction/initialize";
  static String verifyTransaction(String reference) =>
      "https://api.paystack.co/transaction/verify/$reference";
  static const listTransactions = "https://api.paystack.co/transaction";

  // default values
  static const String currentCustomer = "createCustomer";
  static const String transaction = "transaction";

  // Product Api Endpoint
  static const String products = "https://fakestoreapi.com/products";
}
