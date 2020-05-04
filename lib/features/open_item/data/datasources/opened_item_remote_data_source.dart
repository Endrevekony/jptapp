import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:meta/meta.dart';

abstract class OpenedItemRemoteDataSource {
  Future<PDFDocument> getPdfItem({@required String url});
}

class OpenedItemRemoteDataSourceImpl implements OpenedItemRemoteDataSource {
  String url;

  OpenedItemRemoteDataSourceImpl({@required this.url});
  @override
  Future<PDFDocument> getPdfItem({@required String url}) async {
    try {
      return await PDFDocument.fromURL(url);
    } catch(e) {
      throw Exception(e.toString());
    }
  }
}
