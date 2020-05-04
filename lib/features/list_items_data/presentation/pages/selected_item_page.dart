import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/list_items_data/presentation/widgets/items_from_model.dart';

class SelectedItemPage extends StatelessWidget {
  final ItemDataModel item;
  const SelectedItemPage({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        centerTitle: true,
        backgroundColor: MyColors.appBarColor,
        title: Text(item.title),
      ),
      body: Center(
          child: Column(
            children: ListTile.divideTiles(
                    context: context,
                    tiles: ItemsFromModel().getItemsFromModel(item, context))
                .toList(),
          ),
      ),
    );
  }
}
