import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/errors/exceptions.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/platform/network_info.dart';
import 'package:jptapp/features/list_items_data/data/datasources/list_items_local_data_source.dart';
import 'package:jptapp/features/list_items_data/data/datasources/list_items_remote_data_source.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/list_items_data/data/repositories/list_item_data_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements ListItemsRemoteDataSource {}

class MockLocalDataSource extends Mock implements ListItemsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetWorkInfo {}

void main() {
  ListItemDataRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ListItemDataRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getItemDataList', () {
    final pdfLinks = [const PdfLinkModel(title: 'title', link: 'links')];
    final testHtml = [const HtmlTagModel(title: 'tags', html: 'htmlCode')];
    final itemData = [
      ItemDataListModel(pdfLinks: pdfLinks, htmlTags: testHtml, title: 'title')
    ];
    final tItemDataList = ListItemsDataModel(itemDataList: itemData);

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.getListItemData();
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getListItemData())
              .thenAnswer((_) async => tItemDataList);
          final result = await repository.getListItemData();
          verify(mockRemoteDataSource.getListItemData());
          expect(result, equals(Right(tItemDataList)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getListItemData())
              .thenAnswer((_) async => tItemDataList);
          await repository.getListItemData();
          verify(mockRemoteDataSource.getListItemData());
          verify(mockLocalDataSource.cacheListItems(tItemDataList));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          when(mockRemoteDataSource.getListItemData())
              .thenThrow(ServerException());
          final result = await repository.getListItemData();
          verify(mockRemoteDataSource.getListItemData());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
    runTestOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(mockLocalDataSource.getLastListItems())
              .thenAnswer((_) async => tItemDataList);
          final result = await repository.getListItemData();
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastListItems());
          expect(result, equals(Right(tItemDataList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          when(mockLocalDataSource.getLastListItems())
              .thenThrow(CacheException());
          final result = await repository.getListItemData();
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastListItems());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}