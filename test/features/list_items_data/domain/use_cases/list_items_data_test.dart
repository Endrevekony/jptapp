import 'package:dartz/dartz.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/list_items_data/domain/repositories/list_items_data_repository.dart';
import 'package:jptapp/features/list_items_data/domain/use_cases/get_list_items_data.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockItemListDataRepository extends Mock
    implements ListItemsDataRepository {}

void main() {
  GetItemListData usecase;
  MockItemListDataRepository mockItemListDataRepository;
  setUp(() {
    mockItemListDataRepository = MockItemListDataRepository();
    usecase = GetItemListData(mockItemListDataRepository);
  });

  final tPdfLinks = [const PdfLinkModel(title: 'cim', link: 'link')];
  final tHtmlTags = [const HtmlTagModel(title: 'tag', html: 'html')];
  final itemData = ItemDataModel(pdfLinks: tPdfLinks, htmlTags: tHtmlTags, title: 'title');
  final Map<String, ItemDataModel> tItemDataList = {
    'id' : itemData
  };

  test('should get the list data from the repository', () async {
    when(mockItemListDataRepository.getListItemData())
        .thenAnswer((_) async => Right(tItemDataList));

    final result = await usecase(NoParams());
    expect(result, Right(tItemDataList));
    verify(mockItemListDataRepository.getListItemData());
    verifyNoMoreInteractions(mockItemListDataRepository);
  });
}