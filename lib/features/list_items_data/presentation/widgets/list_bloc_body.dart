import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/list_items_data/presentation/bloc/bloc/list_items_bloc.dart';
import 'package:jptapp/features/list_items_data/presentation/pages/selected_item_page.dart';
import 'package:jptapp/injection_container.dart';

class ListBlocBody {
  BlocProvider<ListItemsBloc> buildBody() {
    return BlocProvider(
      create: (_) => sl<ListItemsBloc>(),
      child: BlocBuilder<ListItemsBloc, ListItemsState>(
        builder: (context, state) {
          if (state is NoData) {
            BlocProvider.of<ListItemsBloc>(context).add(GetDataListForItems());
            return Container();
          } else if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            final _list = state.itemDataList.values.toList();
            return Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: <Widget>[
                  for (var i = 0; i < _list.length; i++)
                    ListTile(
                      title: Text(_list[i].title),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectedItemPage(item: _list[i]),
                        ),),
                    ),
                ],
              ).toList(),
            );
          } else if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}