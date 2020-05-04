import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/open_item/domain/repositories/opened_item_repository.dart';
import 'package:meta/meta.dart';

class GetPdfData implements UseCase<PDFDocument, Params> {
  final OpenedItemRepository repository;

  GetPdfData(this.repository);

  @override
  Future<Either<Failure, PDFDocument>> call(Params params) {
    return repository.getPdfData(url: params.url);
  }
}

class Params extends Equatable {
  final String url;

  const Params({@required this.url});

  @override
  List<Object> get props => [url];
}