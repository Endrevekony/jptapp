import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/features/list_items_data/domain/entities/list_items_data.dart';

abstract class ListItemsDataRepository {
  Future<Either<Failure, ListItemsData>> getListItemData();
}
