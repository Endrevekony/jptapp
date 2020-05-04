import 'package:flutter/foundation.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:jptapp/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OpenedItemLocalDataSource {
  Future<PDFDocument> getPdfItem();
  Future<void> cachePdfItem(PDFDocument pdfToCache);
}

const cachedItems = 'CACHED_ITEMS';

class OpenedItemLocalDataSourceImpl implements OpenedItemLocalDataSource {
  final SharedPreferences sharedPreferences;

  OpenedItemLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<PDFDocument> getPdfItem() {
    final pdfItem = sharedPreferences.getString(cachedItems);
    if (pdfItem != null) {
      return Future.value(PDFDocument.fromURL(pdfItem));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePdfItem(PDFDocument pdfToCache) {
    return sharedPreferences.reload();
  }
}