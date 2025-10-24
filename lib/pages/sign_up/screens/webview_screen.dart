
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/utils.dart';
import '../cubit/top_stepper_cubit.dart';
import '../sign_up.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.bridgeToken});
  final String bridgeToken;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    context.read<SignUpBloc>().add(WebviewFetchLoadingStarted());

    _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..addJavaScriptChannel(
      'FlutterBridge',
      onMessageReceived: (message) {
        context.read<SignUpBloc>().add(WebviewMessageReceived(message.message));
      }
    )
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
        onPageStarted: (url) => context.read<SignUpBloc>().add(WebviewFetchLoadingStarted()),
        onPageFinished: (url) => context.read<SignUpBloc>().add(WebviewFetchLoadingSucceeded()),
        onWebResourceError: (error) => context.read<SignUpBloc>().add(WebviewFetchFailed(error.description)),
        onHttpError: (error) => context.read<SignUpBloc>().add(WebviewFetchFailed("HTTP Error ${error.response!.statusCode}")),
        onSslAuthError: (request) => context.read<SignUpBloc>().add(WebviewFetchFailed(TextString.error)),
      )
    );
    _loadUrl();
  }

  void _loadUrl() {
    final webUrl = Uri.https(
      'fcb-pay-signup-amplify.d128fimxs7ouf2.amplifyapp.com',
      '/',
      {'bridgeToken': widget.bridgeToken}
    ).toString();
    
    _controller.loadRequest(Uri.parse(webUrl));
  }

  /// Sends a structured message from host → Flutter Web
  Future<void> sendToWeb(Map<String, dynamic> data) async {
    final jsonString = jsonEncode(data);
    await _controller.runJavaScript("""
      if (window.onSignupSaved) {
        window.onSignupSaved('$jsonString');
      }
    """);
  }

  void _retry() {
    context.read<SignUpBloc>().add(WebviewFetchReset());
    _loadUrl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.webBridgeStatus.isSuccess) {
          context.read<TopStepperCubit>().goNext();
        }
        if (state.webBridgeStatus.isFailure) {
          _showFailureSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state.webviewStatus.isLoading) {
          return Center(child: SpinKitFadingCircle(
            color: ColorString.eucalyptus,
            size: 30,
          ));
        }
        if (state.webviewStatus.isFailure) {
          return _buildErrorView(state.message);
        }
        return WebViewWidget(controller: _controller);
      },
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
                "Oops! Something went wrong.",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
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

  // show failure snackbar
  void _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.white
    ));
  }
}
