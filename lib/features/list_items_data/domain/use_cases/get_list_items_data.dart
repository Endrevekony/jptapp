import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/list_items_data/domain/entities/list_items_data.dart';
import 'package:jptapp/features/list_items_data/domain/repositories/list_items_data_repository.dart';

class GetItemListData extends UseCase<ListItemsData, NoParams> {
  final ListItemsDataRepository repository;
  GetItemListData(this.repository);

  @override
  Future<Either<Failure, ListItemsData>> call(NoParams params) {
    return repository.getListItemData();
  }
}
