import 'dart:ui';

import 'package:flutter/services.dart';

class Share {
  static const MethodChannel _channel = const MethodChannel('jademind.com/share');

  /// Share a file with other apps.
  ///
  /// Pass a [rect] to indicate the position a share
  /// action was initiated from.
  static Future<void> file(String subject, String filename, String filepath, String mimeType, {Rect rect}) async {
    Map argsMap = Map<String, dynamic>();
    argsMap.addAll({'subject': '$subject', 'filename': '$filename', 'filepath': '$filepath', 'mimeType': '$mimeType'});

    if (rect != null) {
      argsMap.addAll({'x': rect.left, 'y': rect.top});
      argsMap.addAll({'width': rect.width, 'height': rect.height,
      });
    }

    _channel.invokeMethod('share-file', argsMap);
  }
}