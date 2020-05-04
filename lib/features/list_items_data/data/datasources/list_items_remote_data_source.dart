import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:jptapp/core/errors/exceptions.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';

abstract class ListItemsRemoteDataSource {
  Future<Map<String, ItemDataModel>> getListItemData();
}

class ListItemsRemoteDataSourceImpl implements ListItemsRemoteDataSource {
  final http.Client client;
  static const String url = 'https://jpt-app.firebaseio.com/.json';

  ListItemsRemoteDataSourceImpl({@required this.client});

  @override
  Future<Map<String, ItemDataModel>> getListItemData() =>
      _getItemsFromUrl(url);

  Future<Map<String, ItemDataModel>> _getItemsFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return listItemsDataModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
