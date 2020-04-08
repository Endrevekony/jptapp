import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/exceptions.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/platform/network_info.dart';
import 'package:jptapp/features/list_items_data/data/datasources/list_items_local_data_source.dart';
import 'package:jptapp/features/list_items_data/data/datasources/list_items_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:jptapp/features/list_items_data/domain/entities/list_items_data.dart';
import 'package:jptapp/features/list_items_data/domain/repositories/list_items_data_repository.dart';

class ListItemDataRepositoryImpl implements ListItemsDataRepository {
  final ListItemsRemoteDataSource remoteDataSource;
  final ListItemsLocalDataSource localDataSource;
  final NetWorkInfo networkInfo;

  ListItemDataRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, ListItemsData>> getListItemData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData =await remoteDataSource.getListItemData();
        localDataSource.cacheListItems(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localItems = await  localDataSource.getLastListItems();
        return Right(localItems);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
