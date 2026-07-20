import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/PaypalService.dart';

/// Drop-in replacement for `UsePaypal`.
///
/// Usage:
/// ```dart
/// Navigator.of(context).push(
///   MaterialPageRoute(
///     builder: (context) => PaypalCheckoutView(
///       sandboxMode: true,
///       clientId: PAYPAL_CLIENT_ID,
///       secretKey: PAYPAL_CLIENT_SECRET,
///       amount: '11',
///       currency: 'USD',
///       description: 'Match Making Request',
///       returnURL: 'https://www.panditbookings.com/return',
///       cancelURL: 'https://www.panditbookings.com/cancel',
///       onSuccess: (Map params) async {
///         final paymentId = params['orderId'];
///         _callsaveMatchdataAPI(paymentId);
///       },
///       onError: (error) => print('onError: $error'),
///       onCancel: () => print('cancelled'),
///     ),
///   ),
/// );
/// ```
class PaypalCheckoutView extends StatefulWidget {
  const PaypalCheckoutView({
    super.key,
    required this.clientId,
    required this.secretKey,
    required this.amount,
    required this.currency,
    required this.description,
    required this.returnURL,
    required this.cancelURL,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    this.sandboxMode = true,
    this.note,
  });

  final String clientId;
  final String secretKey;
  final String amount;
  final String currency;
  final String description;
  final String returnURL;
  final String cancelURL;
  final bool sandboxMode;
  final String? note;

  final Future<void> Function(Map<String, dynamic> params) onSuccess;
  final void Function(Object error) onError;
  final VoidCallback onCancel;

  @override
  State<PaypalCheckoutView> createState() => _PaypalCheckoutViewState();
}

class _PaypalCheckoutViewState extends State<PaypalCheckoutView> {
  late final PaypalService _service;
  WebViewController? _controller;
  String? _orderId;
  bool _loading = true;
  String? _errorMessage;
  bool _finished = false; // guards against duplicate capture/cancel firing

  @override
  void initState() {
    super.initState();
    _service = PaypalService(
      clientId: widget.clientId,
      clientSecret: widget.secretKey,
      sandboxMode: widget.sandboxMode,
    );
    _init();
  }

  Future<void> _init() async {
    try {
      final order = await _service.createOrder(
        amount: widget.amount,
        currency: widget.currency,
        description: widget.description,
        returnUrl: widget.returnURL,
        cancelUrl: widget.cancelURL,
      );
      _orderId = order.orderId;

      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: _handleNavigation,
            onWebResourceError: (error) {
              widget.onError(error.description);
            },
          ),
        )
        ..loadRequest(Uri.parse(order.approvalUrl));

      setState(() {
        _controller = controller;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = e.toString();
      });
      widget.onError(e);
    }
  }

  NavigationDecision _handleNavigation(NavigationRequest request) {
    final url = request.url;

    if (_finished) return NavigationDecision.navigate;

    if (url.startsWith(widget.returnURL)) {
      _finished = true;
      _capture();
      return NavigationDecision.prevent;
    }

    if (url.startsWith(widget.cancelURL)) {
      _finished = true;
      widget.onCancel();
      if (mounted) Navigator.of(context).pop();
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  Future<void> _capture() async {
    if (_orderId == null) return;
    setState(() => _loading = true);
    try {
      final result = await _service.captureOrder(_orderId!);
      await widget.onSuccess({
        'orderId': _orderId,
        'raw': result,
      });
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      widget.onError(e);
      if (mounted) {
        setState(() {
          _loading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayPal Checkout')),
      body: Stack(
        children: [
          if (_controller != null) WebViewWidget(controller: _controller!),
          if (_loading)
            const Center(child: CircularProgressIndicator()),
          if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Payment failed:\n$_errorMessage',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}