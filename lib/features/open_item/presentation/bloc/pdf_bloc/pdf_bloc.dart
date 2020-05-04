import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/features/open_item/domain/usecases/get_opened_item.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  static const String serverFailureMessage = 'Server Failure';
  static const String cacheFailureMessage= 'Cache Failure';

  final GetPdfData getPdfData;
  PdfBloc({
    @required GetPdfData getPdfData,
  })  : assert(getPdfData != null),
        getPdfData = getPdfData;

  @override
  PdfState get initialState => NoData();

  @override
  Stream<PdfState> mapEventToState(
      PdfEvent event,
      ) async* {
    if (event is GetPdfItem){
      yield Loading();
      final failureOrNot = await getPdfData(Params(url: event.url));
      yield* _eitherLoadedOrErrorState(failureOrNot);
    }
  }
  Stream<PdfState> _eitherLoadedOrErrorState(
      Either<Failure,PDFDocument> either,
      ) async* {
    yield  either.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (pdfDocument) => Loaded(pdfDocument: pdfDocument),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
