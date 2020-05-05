import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

abstract class OpenedItemRemoteDataSource {
  Future<PDFDocument> getPdfItem(String url);
}

class OpenedItemRemoteDataSourceImpl implements OpenedItemRemoteDataSource {
  @override
  Future<PDFDocument> getPdfItem(String url) async {
    try {
      return await PDFDocument.fromURL(url);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
