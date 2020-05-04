part of 'list_items_bloc.dart';

@immutable
abstract class ListItemsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoData extends ListItemsState {}

class Loading extends ListItemsState {}

class Loaded extends ListItemsState {
  final Map<String, ItemDataModel> itemDataList;
  Loaded({@required this.itemDataList});
  @override
  List<Object> get props => [itemDataList];
}

class Error extends ListItemsState {
  final String message;
  Error({@required this.message});
  @override
  List<Object> get props => [message];
}