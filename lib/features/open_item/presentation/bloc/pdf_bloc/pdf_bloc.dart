import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/features/open_item/domain/usecases/get_opened_item.dart';
import 'package:jptapp/features/open_item/presentation/bloc/pdf_bloc/pdf_event.dart';
import 'package:jptapp/features/open_item/presentation/bloc/pdf_bloc/pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  String serverFailureMessage = 'Server Failure';
  String cacheFailureMessage = 'Cache Failure';

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
    if (event is GetPdfItem) {
      yield Loading();
      final failureOrNot = await getPdfData(Params(url: event.url));
      yield* _eitherLoadedOrErrorState(failureOrNot);
    }
  }

  Stream<PdfState> _eitherLoadedOrErrorState(
    Either<Failure, PDFDocument> either,
  ) async* {
    yield either.fold(
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
