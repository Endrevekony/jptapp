part of 'list_items_bloc.dart';

@immutable
abstract class ListItemsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataListForItems extends ListItemsEvent {}