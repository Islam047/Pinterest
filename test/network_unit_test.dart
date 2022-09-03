import 'package:flutter_test/flutter_test.dart';
import 'package:pinterest/models/list_photos_model.dart';
import 'package:pinterest/models/searchCollectionModel.dart';

import 'package:pinterest/services/network_service.dart';

void main() {
   // #allPhotosTest
  group("Test:2 get all photos", () {
    String? response;
    test('test:2 get all photos', () async {
      response = '';
      response = await NetworkService.GET(
          NetworkService.API_ALL_USERS, NetworkService.paramsAllPhotos());
      print(response);

      expect(response, isNotNull);
    });
    List<ListPhotos> listOfUsers;
    test('test:2 parse all photos', () async {
      listOfUsers = parseAllUsers(response!);
      expect(listOfUsers, isNotEmpty);
    });
  });
  // #allCollectionTest
  group("Test:3 get search collection", () {
    String? response;
    test('test:1 get from search collection', () async {
      response = await NetworkService.GET(NetworkService.API_COLLECTIONS_LIST,
          NetworkService.paramsAllCollections());

      expect(response, isNotNull);
    });
    List<CollectionModel> searchCollectionModel;
    test("test:2 parse all from search collection", () {
      print(response);
      searchCollectionModel = parseAllCollection(response!);
      expect(searchCollectionModel, isNotNull);
    });


    test('test:3 get user from search collection', () async {
      response = '';
      response = await NetworkService.GET(NetworkService.API_SEARCH_USER,
          NetworkService.paramsSearchPhotosQuery());
      expect(response, isNotNull);
    });
    CollectionModel model;
    test("test:4 parse user from search collection", () {
      model = collectionModelFromJson(response!);
      expect(model, isNotNull);
    });
  });
  // #allCollectionListTest
  group("Test:4 get a list collection", () {
    String? response;
    test("test:1  get All list collection", () async {
      response = await NetworkService.GET(NetworkService.API_COLLECTIONS_LIST,
          NetworkService.paramsAllCollections());
      print(response);
      expect(response, isNotNull);
    });
  });
}
