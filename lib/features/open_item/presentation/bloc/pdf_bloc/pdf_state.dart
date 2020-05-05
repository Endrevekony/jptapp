import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

@immutable
abstract class PdfState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoData extends PdfState {}

class Loading extends PdfState {}

class Loaded extends PdfState {
  final PDFDocument pdfDocument;
  Loaded({@required this.pdfDocument});
  @override
  List<Object> get props => [pdfDocument];
}

class Error extends PdfState {
  final String message;
  Error({@required this.message});
  @override
  List<Object> get props => [message];
}
