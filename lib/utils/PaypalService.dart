import 'dart:convert';
import 'package:http/http.dart' as http;

/// Thin wrapper around PayPal's Orders v2 REST API.
/// Replaces the broken `UsePaypal` widget from flutter_paypal_payment,
/// which relies on PayPal's legacy/deprecated Checkout.js web flow.
class PaypalService {
  PaypalService({
    required this.clientId,
    required this.clientSecret,
    this.sandboxMode = true,
  });

  final String clientId;
  final String clientSecret;
  final bool sandboxMode;

  String get _baseUrl => sandboxMode
      ? 'https://api-m.sandbox.paypal.com'
      : 'https://api-m.paypal.com';

  /// Gets an OAuth2 access token using client credentials.
  Future<String> _getAccessToken() async {
    final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

    final response = await http.post(
      Uri.parse('$_baseUrl/v1/oauth2/token'),
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode != 200) {
      throw PaypalException(
        'Failed to get access token: ${response.statusCode} ${response.body}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['access_token'] as String;
  }

  /// Creates a PayPal order and returns the order id plus the approval
  /// URL the user needs to be redirected to (open this in the WebView).
  Future<PaypalOrder> createOrder({
    required String amount,
    required String currency,
    required String description,
    required String returnUrl,
    required String cancelUrl,
  }) async {
    final accessToken = await _getAccessToken();

    final response = await http.post(
      Uri.parse('$_baseUrl/v2/checkout/orders'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'intent': 'CAPTURE',
        'purchase_units': [
          {
            'description': description,
            'amount': {
              'currency_code': currency,
              'value': amount,
            },
          }
        ],
        'application_context': {
          'return_url': returnUrl,
          'cancel_url': cancelUrl,
          'user_action': 'PAY_NOW',
          'shipping_preference': 'NO_SHIPPING',
        },
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw PaypalException(
        'Failed to create order: ${response.statusCode} ${response.body}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final orderId = data['id'] as String;

    final links = (data['links'] as List).cast<Map<String, dynamic>>();
    final approveLink = links.firstWhere(
          (link) => link['rel'] == 'approve' || link['rel'] == 'payer-action',
      orElse: () => throw PaypalException('No approval link in response'),
    );

    return PaypalOrder(
      orderId: orderId,
      approvalUrl: approveLink['href'] as String,
    );
  }

  /// Captures (finalizes) a previously approved order.
  Future<Map<String, dynamic>> captureOrder(String orderId) async {
    final accessToken = await _getAccessToken();

    final response = await http.post(
      Uri.parse('$_baseUrl/v2/checkout/orders/$orderId/capture'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw PaypalException(
        'Failed to capture order: ${response.statusCode} ${response.body}',
      );
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}

class PaypalOrder {
  PaypalOrder({required this.orderId, required this.approvalUrl});
  final String orderId;
  final String approvalUrl;
}

class PaypalException implements Exception {
  PaypalException(this.message);
  final String message;
  @override
  String toString() => 'PaypalException: $message';
}