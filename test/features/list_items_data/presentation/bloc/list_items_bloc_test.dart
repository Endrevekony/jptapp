import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/list_items_data/domain/entities/list_items_data.dart';
import 'package:jptapp/features/list_items_data/domain/use_cases/get_list_items_data.dart';
import 'package:jptapp/features/list_items_data/presentation/bloc/bloc/list_items_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetListItems extends Mock implements GetItemListData {}

void main() {
  ListItemsBloc bloc;
  MockGetListItems mockGetListItems;

  setUp(() {
    mockGetListItems = MockGetListItems();

    bloc = ListItemsBloc(
      getItemDataList: mockGetListItems,
    );
  });

  final tPdfLinks = [const PdfLinks(title: 'cim', link: 'link')];
  final tHtmlTags = [const HtmlTags(title: 'tag', html: 'html')];
  final itemData = ItemData(pdfLinks: tPdfLinks, htmlTags: tHtmlTags, title: 'valami');
  final Map<String, ItemDataModel> tItemDataList = {
    'id' : itemData,
  };

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(NoData()));
  });

  test('should get data from the use case', () async {});

  group(
    'GetListItems',
    () {
      test(
        'should get data from the use case',
        () async {
          // arrange
          when(mockGetListItems(any))
              .thenAnswer((_) async => Right(tItemDataList));
          // act
          bloc.add(GetDataListForItems());
          await untilCalled(mockGetListItems(any));
          // assert
          verify(mockGetListItems(NoParams()));
        },
      );

      test(
        'should emit [Loading, Loaded] when data is gotten successfully',
        () async {
          // arrange
          when(mockGetListItems(any))
              .thenAnswer((_) async => Right(tItemDataList));
          // assert later
          final expected = [
            NoData(),
            Loading(),
            Loaded(itemDataList: tItemDataList),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetDataListForItems());
        },
      );

      test(
        'should emit [Loading, Error] when getting data fails',
        () async {
          // arrange
          when(mockGetListItems(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // assert later
          final expected = [
            NoData(),
            Loading(),
            Error(message: ListItemsBloc.serverFailureMessage),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetDataListForItems());
        },
      );

      test(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async {
          // arrange
          when(mockGetListItems(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          // assert later
          final expected = [
            NoData(),
            Loading(),
            Error(message: ListItemsBloc.cacheFailureMessage),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetDataListForItems());
        },
      );
    },
  );
}
