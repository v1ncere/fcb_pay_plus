import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../scanner/widgets/widgets.dart';
import '../bloc/merchant_add_bloc.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    detectionTimeoutMs: 1000,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    double area = screen.width < 400 || screen.height < 400 ? 250.0 : 360.0;
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: area,
      height: area,
    );
    return InactivityDetector(
      onInactive: () => context.goNamed(RouteName.authPin),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'QR SCANNER', 
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ColorString.eucalyptus
            )
          ),
          leading: IconButton(
            onPressed: () => context.read<MerchantAddBloc>().add(MerchantIsScannerChanged(Scanner.display)), 
            icon: Icon(FontAwesomeIcons.arrowLeft, size: 18)
          ),
          actions: [
            toggleTorch(),
          ]
        ),
        body: BlocListener<MerchantAddBloc, MerchantAddState>(
          listener: (context, state) {
            if (state.createStatus.isSuccess) {
              context.read<MerchantAddBloc>().add(MerchantIsScannerChanged(Scanner.display));
            }
            if (state.createStatus.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Stack(
            children: [
              MobileScanner(
                controller: _controller,
                placeholderBuilder: (context) => Container(color: Colors.black),
                errorBuilder: (context, error) {
                  return ScannerErrorWidget(error: error, area: area);
                },
                scanWindow: scanWindow,
                onDetect: _handleBarcode
              ),
              ScanWindowOverlay(
                controller: _controller,
                scanWindow: scanWindow,
                borderColor: ColorString.eucalyptus,
                borderRadius: BorderRadius.circular(15),
              ),
              const ScannerText(),
            ]
          )
        )
      )
    );
  }

  // *** UTILITY METHODS ***

  void _handleBarcode(BarcodeCapture event) {
    context.read<MerchantAddBloc>().add(MerchantAddCreated(event.barcodes.first.rawValue!));
  }

  Widget toggleTorch() {
    return  IconButton(
      color: Colors.white,
      iconSize: 32.0,
      icon: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, state, child) {
          if (!state.isInitialized || !state.isRunning) {
            return const SizedBox.shrink();
          }

          switch (state.torchState) {
            case TorchState.auto:
              return const Icon(
                Icons.flash_auto_rounded,
                size: 18,
                color:Colors.grey
              );
            case TorchState.off:
              return const Icon(
                Icons.flash_on_rounded,
                size: 18,
                color:Colors.grey
              );
            case TorchState.on:
              return const Icon(
                Icons.flash_off_rounded,
                size: 18, 
                color:Colors.yellow
              );
            case TorchState.unavailable:
              return const Icon(
                Icons.no_flash_rounded,
                size: 18, 
                color:Colors.grey
              );
          }
        }
      ),
      onPressed: () => _controller.toggleTorch()
    );
  }
}
