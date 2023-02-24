import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ImageTools {
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Image imageFromBase64(String base64Img, Size sizeImge) {
    var tmpphotoActeur = Base64Decoder().convert(base64Img);
    return Image.memory(tmpphotoActeur,
        width: sizeImge.width, height: sizeImge.height);
  }
}
