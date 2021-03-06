import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/list_items_data/domain/use_cases/get_list_items_data.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_items_event.dart';
part 'list_items_state.dart';


class ListItemsBloc extends Bloc<ListItemsEvent, ListItemsState> {
  static const String serverFailureMessage = 'Server Failure';
  static const String cacheFailureMessage= 'Cache Failure';

  final GetItemListData getItemDataList;
  ListItemsBloc({
    @required GetItemListData getItemDataList,
  })  : assert(getItemDataList != null),
        getItemDataList = getItemDataList;

  @override
  ListItemsState get initialState => NoData();

  @override
  Stream<ListItemsState> mapEventToState(
      ListItemsEvent event,
      ) async* {
    if (event is GetDataListForItems) {
      yield Loading();
      final failureOrNot = await getItemDataList(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrNot);
    }
  }
  Stream<ListItemsState> _eitherLoadedOrErrorState(
      Either<Failure, Map<String, ItemDataModel>> either,
      ) async* {
    yield either.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (itemDataList) => Loaded(itemDataList: itemDataList),
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
