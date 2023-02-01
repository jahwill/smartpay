import 'package:dio/dio.dart';

import 'base_service.dart';

class InitPayStack extends BaseService {
  Future<Response?> initPayment(String token,
      {required Map<String, dynamic> payload}) async {
    Response? res;

    try {
      res = await post(
        'transaction/initialize',
        payload,
        token: token,
      );
      // print("res");
      return res;
    } on DioError catch (err) {
      if (err.type == DioErrorType.other) {
      } else {
        res = err.response;
      }
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<Response?> verifyPaymentPayment(String token,
      {required String referenceID}) async {
    Response? res;

    try {
      res = await get(
        'transaction/verify/:$referenceID',
        token: token,
      );

      return res;
    } on DioError catch (err) {
      if (err.type == DioErrorType.other) {
      } else {
        res = err.response;
      }
      return res;
    } catch (e) {
      return null;
    }
  }
}
