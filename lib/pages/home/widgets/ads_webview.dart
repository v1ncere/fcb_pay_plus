import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/utils.dart';
import '../bloc/home_webview_bloc.dart';

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
    context.read<HomeWebviewBloc>().add(WebviewFetchLoadingStarted());

    _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) {
          final url = request.url;
          // ✅ Success
          if (url.startsWith("fcbpayplus://signup-success")) {
            context.pop({"status": "success"});
            return NavigationDecision.prevent;
          }
          // ❌ Failure with reason
          if (url.startsWith("fcbpayplus://signup-failed")) {
            final uri = Uri.parse(url);
            final reason = uri.queryParameters["reason"] ?? "unknown";

            context.pop({
              "status": "failed",
              "reason": reason,
            });
            return NavigationDecision.prevent;
          }
          //
          return NavigationDecision.navigate;
        },
        onPageStarted: (url) => context.read<HomeWebviewBloc>().add(WebviewFetchLoadingStarted()),
        onPageFinished: (url) => context.read<HomeWebviewBloc>().add(WebviewFetchLoadingSucceeded()),
        onWebResourceError: (error) => context.read<HomeWebviewBloc>().add(WebviewFetchFailed(error.description)),
        onHttpError: (error) => context.read<HomeWebviewBloc>().add(WebviewFetchFailed("HTTP Error ${error.response!.statusCode}")),
        onSslAuthError: (request) => context.read<HomeWebviewBloc>().add(WebviewFetchFailed(TextString.error)),
      )
    );

    _loadUrl();
  }

  void _loadUrl() {
    final webUrl = Uri.https('fcb.com.ph', '',).toString();
    _controller.loadRequest(Uri.parse(webUrl));
  }
  
  void _retry() {
    context.read<HomeWebviewBloc>().add(WebviewFetchReset());
    _loadUrl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWebviewBloc, HomeWebviewState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: ColorString.eucalyptus,
              size: 30,
            )
          );
        }
        if (state.status.isFailure) {
          return _buildErrorView(state.message);
        }
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: WebViewWidget(controller: _controller),
        );
      }
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