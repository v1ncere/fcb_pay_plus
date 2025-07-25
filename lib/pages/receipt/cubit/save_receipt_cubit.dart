import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

import '../../../utils/utils.dart';

part 'save_receipt_state.dart';

class SaveReceiptCubit extends Cubit<SaveReceiptState> {
  SaveReceiptCubit() : super(const SaveReceiptState());

  Future<void> takeScreenshot(GlobalKey key) async {
    emit(state.copyWith(status: Status.loading));
    
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData != null) {
      try {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        await ImageGallerySaverPlus.saveImage(
          Uint8List.fromList(pngBytes),
          quality: 90,
          name: 'screenshot-${DateTime.now()}.png'
        );
        emit(state.copyWith(status: Status.success));
      } catch (e) {
        emit(state.copyWith(status: Status.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(status: Status.failure, message: 'Byte data not found'));
    }
  }
}
