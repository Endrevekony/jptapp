import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/list_items_data/domain/entities/list_items_data.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final pdfLinks = [const PdfLinkModel(title: 'title', link: 'link')];
  final testHtml = [const HtmlTagModel(title: 'title', html: 'htmlCode')];
  final itemData = [
    ItemDataListModel(pdfLinks: pdfLinks, htmlTags: testHtml, title: 'title'),
    ItemDataListModel(pdfLinks: pdfLinks, htmlTags: testHtml, title: 'title')
  ];
  final tListItemDataModel = ListItemsDataModel(itemDataList: itemData);

  test(
    'should be a subclass of ListItemsData entity',
    () async {
      expect(tListItemDataModel, isA<ListItemsData>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when the Json is pdfLink or htmlTag',
        () async {
          final jsonString = fixture('items.json');
          final result = listItemsDataModelFromJson(jsonString);
          expect(result, tListItemDataModel);
        });
  });

  group('toJson', ()
  {
    test( 
      'should return a JSON map containing the proper data',
          () async {
            final result = jsonDecode(listItemsDataModelToJson(tListItemDataModel)); //most
            final expectedJsonMap = jsonDecode(fixture('items.json'));
            expect(result, expectedJsonMap);
      },
    );
  });
}

