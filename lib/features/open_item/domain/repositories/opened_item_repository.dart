import 'package:dartz/dartz.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:meta/meta.dart';
import 'package:jptapp/core/errors/failures.dart';

abstract class OpenedItemRepository {
  Future<Either<Failure, PDFDocument>> getPdfData({@required String url});
}