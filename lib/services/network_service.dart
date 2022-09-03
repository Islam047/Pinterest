import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest/services/log_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:universal_html/html.dart' hide File, Platform;
import 'interceptor_service.dart';

class NetworkService {
  // #baseurl
  static const DEVELOPMENT_SERVER = 'api.unsplash.com';
  static const DEPLOYMENT_SERVER = 'api.unsplash.com';
  static bool isTester = true;

  static String get BASEURL {
    if (isTester) {
      return DEVELOPMENT_SERVER;
    } else {
      return DEPLOYMENT_SERVER;
    }
  }

  // #apis
  static const API_ALL_USERS = '/photos';
  static const API_LIKE_PHOTO = '/photos/';
  static const API_RANDOM_PHOTO = '/photos/random';
  static const API_ONE_USER = '/users/';
  static const API_SEARCH_COLLECTION = '/search/collections';
  static const API_SEARCH_PHOTOS = '/search/photos';
  static const API_SEARCH_USER = '/search/users';
  static const API_COLLECTIONS_LIST = '/collections';
  static const API_COLLECTIONS_BY_ID = '/collections/';
  static const API_GET_TOPIC = '/topics/';

// #interceptor
  static final http = InterceptedHttp.build(interceptors: [
    InterceptorService(),
  ]);

// #headers

// #METHODS
  // #GET
  static Future<String?> GET(String api, Map<String, String> params) async {
    Uri uri = Uri.https(BASEURL, api, params);
    Response response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<void> GETDOWNLOAD(String image, String name) async {
    Directory? appDir;
    bool isExist;
    Response response = await http.get(Uri.parse(image));
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.request().isGranted &&
          await Permission.storage.request().isGranted) {
        appDir = Directory("storage/emulated/0/Pinterest");
      }
    } else if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    }

    isExist = await appDir!.exists();
    if (!isExist) {
      await appDir.create();
    }
    File? imageFile = File('${appDir.path + name}.png');
    await imageFile.writeAsBytes(response.bodyBytes);
  }

  static Future<void> GETDOWNLOADWEB(String image,String name) async {
    try {
      Response response = await get(
        Uri.parse(image),
      );
      final data = response.bodyBytes;
      String base64data = base64Encode(data);
      AnchorElement a = AnchorElement(href: 'data:image/jpeg;base64,$base64data');
      a.download = '$name.jpg';
      a.click();
      a.remove();
    } catch (e) {
      print(e);
    }
  }

// #POST
  static Future<String?> POST(
      String api, Map<String, String> params, Map<String, dynamic> body) async {
    Uri uri = Uri.https(BASEURL, api);
    Response response =
        await http.post(uri, body: jsonEncode(body), params: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }

    return null;
  }

// #PUT
  static Future<String?> PUT(
      String api, Map<String, String> params, Map<String, dynamic> body) async {
    Uri uri = Uri.https(BASEURL, api, params);
    Response response = await http.put(uri, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }

    return null;
  }

// #DELETE
  static Future<String?> DELETE(String api, Map<String, String> params) async {
    Uri uri = Uri.https(BASEURL, api, params);
    Response response = await http.delete(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }

    return null;
  }

// #MULTIPART
  static Future<String?> MULTIPART(
      String api, String filePath, Map<String, String> body) async {
    Uri uri = Uri.https(BASEURL, api);
    MultipartRequest request = MultipartRequest("POST", uri);
    // TODO headers for upload

    request.files.add(await MultipartFile.fromPath("file", filePath,
        contentType: MediaType("image", "jpeg")));
    request.fields.addAll(body);
    StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      LogService.o(response.reasonPhrase.toString());
      LogService.o(response.statusCode.toString());
      return await response.stream.bytesToString();
    } else {
      LogService.e(response.reasonPhrase.toString());
      return response.reasonPhrase;
    }
  }

// #params
  // #paramsAllPhotos
  static Map<String, String> paramsAllPhotos(
      {int? page = 1, int? perPage = 10, String? orderBy = "latest"}) {
    // orderBy: latest, oldest, popular
    Map<String, String> map = {
      "page": page.toString(),
      "per_page": perPage.toString(),
      "order_by": orderBy!,
      'client_id': '5hfqQrLCqLi2GVcFegKqUfB8Eb9VKBisFrpNuoEiwqM',
    };

    return map;
  }

  // #paramsMyKey
  static Map<String, String> paramsMyKey() {
    Map<String, String> map = {
      'client_id': "5hfqQrLCqLi2GVcFegKqUfB8Eb9VKBisFrpNuoEiwqM",
    };
    return map;
  }

  // #paramsAllCollections
  static Map<String, String> paramsAllCollections({
    int? page = 1,
    int? perPage = 10,
  }) {
    Map<String, String> map = {
      'client_id': 'x0bUqP0ZiZfwSdPSu8n-JEKUJ_fh9GEV_lDA2XMj5as',
      "page": page.toString(),
      "per_page": perPage.toString(),
    };
    return map;
  }

  // #paramsSearchPhotosQuery
  static Map<String, String> paramsSearchPhotosQuery(
      {String? query = "wallpaper", int? page = 1, int? perPage = 20}) {
    Map<String, String> map = {
      "query": query!,
      "page": page.toString(),
      "per_page": perPage.toString(),
      'client_id': '5hfqQrLCqLi2GVcFegKqUfB8Eb9VKBisFrpNuoEiwqM',
    };
    return map;
  }

  // #paramsGetOneUser
  static Map<String, String> paramsGetOneUser(String username) {
    Map<String, String> map = {
      'username': username,
    };
    return map;
  }

  // #paramsGetCollectionsPhotos
  static Map<String, String> paramsGetCollectionsPhotos(String id) {
    Map<String, String> map = {
      'id': id,
    };
    return map;
  }

  // #paramsEmpty
  static Map<String, String> paramsEmpty() {
    Map<String, String> map = {};
    return map;
  }

// #bodys
}
