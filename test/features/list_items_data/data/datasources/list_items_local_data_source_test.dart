
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/errors/exceptions.dart';
import 'package:jptapp/features/list_items_data/data/datasources/list_items_local_data_source.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences{}

void main() {
  ListItemsLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      dataSource = ListItemsLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final tPdfLinks = [const PdfLinkModel(title: 'cim', link: 'link')];
  final tHtmlTags = [const HtmlTagModel(title: 'tag', html: 'html')];
  final itemData = ItemDataModel(pdfLinks: tPdfLinks, htmlTags: tHtmlTags, title: 'title');
  final Map<String, ItemDataModel> tItemDataList = {
    'id' : itemData
  };

  group('getLastItems', () {
    test('should return items from shared preferences when there are in the cache', () async {
        when(mockSharedPreferences.getString(any)).thenReturn(fixture('items.json'));
        final result = await dataSource.getLastListItems();
        verify(mockSharedPreferences.getString(cachedItems));
        expect(result, equals(tItemDataList));
      });
    test('should throw CacheException if there is no cache', () async {
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        final call = dataSource.getLastListItems;
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      });
  });
}