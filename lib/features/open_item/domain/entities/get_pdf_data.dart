import 'package:equatable/equatable.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:meta/meta.dart';

class PdfData extends Equatable {
  final Future<PDFDocument> pdfDocument;

  const PdfData({
    @required this.pdfDocument,
  });

  @override
  List<Object> get props => [pdfDocument];
}