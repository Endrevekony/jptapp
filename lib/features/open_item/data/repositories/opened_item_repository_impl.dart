import 'package:dartz/dartz.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:jptapp/core/errors/exceptions.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/platform/network_info.dart';
import 'package:jptapp/features/open_item/data/datasources/opened_item_local_data_source.dart';
import 'package:jptapp/features/open_item/data/datasources/opened_item_remote_data_source.dart';
import 'package:jptapp/features/open_item/domain/repositories/opened_item_repository.dart';
import 'package:meta/meta.dart';

class OpenedItemRepositoryImpl implements OpenedItemRepository {
  final OpenedItemRemoteDataSource remoteDataSource;
  final OpenedItemLocalDataSource localDataSource;
  final NetWorkInfo networkInfo;

  OpenedItemRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PDFDocument>> getPdfData(
      {@required String url}) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePdf = await remoteDataSource.getPdfItem(url);
        //localDataSource.cachePdfItem(remotePdf);
        return Right(remotePdf);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPdf = await localDataSource.getPdfItem();
        return Right(localPdf);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
