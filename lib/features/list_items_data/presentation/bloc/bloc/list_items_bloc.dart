import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/list_items_data/domain/use_cases/get_list_items_data.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jptapp/features/list_items_data/domain/entities/list_items_data.dart';

part 'list_items_event.dart';
part 'list_items_state.dart';


class ListItemsBloc extends Bloc<ListItemsEvent, ListItemsState> {
    static const String SERVER_FAILURE_MESSAGE = 'Server Failure';
  static const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

  final GetItemListData getItemDataList;
  ListItemsBloc({
    @required GetItemListData getItemDataList,
  })  : assert(getItemDataList != null),
        getItemDataList = getItemDataList;

  @override
  ListItemsState get initialState => Empty();

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
}

Stream<ListItemsState> _eitherLoadedOrErrorState(
  Either<Failure, ListItemsData> either,
) async* {
  yield either.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (itemDataList) => Loaded(itemDataList: itemDataList),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server Error';
    case CacheFailure:
      return 'Cache Error';
    default:
      return 'Unexpected Error';
  }
}