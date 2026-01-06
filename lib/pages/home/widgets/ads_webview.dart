import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdsWebview extends StatefulWidget {
  const AdsWebview({super.key});

  @override
  State<AdsWebview> createState() => _AdsWebviewState();
}

class _AdsWebviewState extends State<AdsWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent);

    _loadUrl();
  }

  void _loadUrl() {
    final webUrl = Uri.https('fcb.com.ph', '',).toString();
    _controller.loadRequest(Uri.parse(webUrl));
  }
  
  void _retry() {
    _loadUrl();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: WebViewWidget(controller: _controller),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
              )
            ]
          )
        )
      )
    );
  }
}