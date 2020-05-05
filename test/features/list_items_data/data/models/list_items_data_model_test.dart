import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final tPdfLinks = [const PdfLinkModel(title: 'cim', link: 'link')];
  final tHtmlTags = [const HtmlTagModel(title: 'tag', html: 'html')];
  final itemData =
      ItemDataModel(pdfLinks: tPdfLinks, htmlTags: tHtmlTags, title: 'title');
  final Map<String, ItemDataModel> tItemDataList = {'id': itemData};

  test(
    'should be a subclass of ListItemsData entity',
    () async {
      expect(tItemDataList, isA<Map<String, ItemDataModel>>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when the Json is pdfLink or htmlTag',
        () async {
      final jsonString = fixture('items.json');
      final result = listItemsDataModelFromJson(jsonString);
      expect(result, tItemDataList);
    });
  });

  group(
    'toJson',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          final result = jsonDecode(listItemsDataModelToJson(tItemDataList));
          final expectedJsonMap = jsonDecode(fixture('items.json'));
          expect(result, expectedJsonMap);
        },
      );
    },
  );
}
