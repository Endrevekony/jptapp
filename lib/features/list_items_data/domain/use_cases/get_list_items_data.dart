import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/list_items_data/domain/repositories/list_items_data_repository.dart';

class GetItemListData extends UseCase<Map<String, ItemDataModel>, NoParams> {
  final ListItemsDataRepository repository;
  GetItemListData(this.repository);

  @override
  Future<Either<Failure, Map<String, ItemDataModel>>> call(NoParams params) {
    return repository.getListItemData();
  }
}
