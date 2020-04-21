import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:jptapp/core/errors/exceptions.dart';
import 'package:jptapp/features/list_items_data/data/datasources/list_items_remote_data_source.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/fixtures/fixture_reader.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  ListItemsRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ListItemsRemoteDataSourceImpl(client: mockHttpClient);
    
  });
  final tListItemsModel = listItemsDataModelFromJson(jsonDecode(fixture('items.json')));

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('items.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }
group('getListItemsData', () {

  test(
    'should preform a GET request on a URL with *random* endpoint with application/json header',
    () {
      //arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getListItemData();
      // assert
      verify(mockHttpClient.get(
        'http://numbersapi.com/',
        headers: {'Content-Type': 'application/json'},
      ));
    },
  );

  test(
    'should return ListItem when the response code is 200 (success)',
    () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getListItemData();
      // assert
      expect(result, equals(tListItemsModel));
    },
  );

  test(
    'should throw a ServerException when the response code is 404 or other',
    () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getListItemData();
      // assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    },
  );
});
}