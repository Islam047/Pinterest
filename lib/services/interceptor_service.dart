import 'package:http_interceptor/http_interceptor.dart';
import 'log_service.dart';


class InterceptorService implements InterceptorContract {
  // #interceptRequest
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {

    LogService.i(data.url.toString());
    return data;
  }
  // #interceptResponse
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    LogService.v(data.statusCode.toString());
    return data;
  }
}