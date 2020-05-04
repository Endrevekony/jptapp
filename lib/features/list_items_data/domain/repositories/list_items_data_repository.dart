import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';

abstract class ListItemsDataRepository {
  Future<Either<Failure, Map<String, ItemDataModel>>> getListItemData();
}
