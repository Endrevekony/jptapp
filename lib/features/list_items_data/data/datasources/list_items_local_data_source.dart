import 'package:jptapp/core/errors/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';

abstract class ListItemsLocalDataSource {
  Future<Map<String, ItemDataModel>> getLastListItems();
  Future<void> cacheListItems(Map<String, ItemDataModel> itemsToCache);
}

const cachedItems = 'CACHED_ITEMS';

class ListItemsLocalDataSourceImpl implements ListItemsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ListItemsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<Map<String, ItemDataModel>> getLastListItems() {
    final jsonString = sharedPreferences.getString(cachedItems);
    if (jsonString != null) {
      return Future.value(listItemsDataModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheListItems(Map<String, ItemDataModel> itemsToCache) {
    return sharedPreferences.setString(
      cachedItems,
      listItemsDataModelToJson(itemsToCache),
    );
  }
}
