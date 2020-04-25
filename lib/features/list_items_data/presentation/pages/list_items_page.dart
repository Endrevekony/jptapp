import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/list_items_data/presentation/bloc/bloc/list_items_bloc.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';
import 'package:jptapp/features/settings/pages/settings_page.dart';
import 'package:jptapp/injection_container.dart';

class ListItemsPage extends StatefulWidget {
  @override
  _ListItemsPageState createState() => _ListItemsPageState();
}

class _ListItemsPageState extends State<ListItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          allTranslations.text('documents'),
        ),
        backgroundColor: MyColors.appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          )
        ],
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.floatingActionButtonColor,
        onPressed: () async {
          //
        },
        child: Icon(
          Icons.camera_enhance,
          color: Colors.white,
        ),
      ),
    );
  }

  BlocProvider<ListItemsBloc> buildBody() {
    return BlocProvider(
      create: (_) => sl<ListItemsBloc>(),
      child: BlocBuilder<ListItemsBloc, ListItemsState>(
        builder: (context, state) {
          if (state is NoData) {
            BlocProvider.of<ListItemsBloc>(context).add(GetDataListForItems());
            return Container();
          } else if (state is Loading) {
            return Center(
                child: CircularProgressIndicator(),
                );
          } else if (state is Loaded) {
            print('loaded');
            print(state.itemDataList);
            return Container();
          } else if (state is Error) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}