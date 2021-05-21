import 'dart:convert';

import 'package:aliceblue_task/Home/OrderModel.dart';
import 'package:aliceblue_task/Home/SchemeModel.dart';
import 'package:aliceblue_task/SchemeDetails/SchemeDetailsModel.dart';
import 'package:aliceblue_task/Utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert' as convert;

class ApiServices{
  final Map<String, String> headers = {"Content-Type": "application/form-data",
  "Content-type": "application/json"};
  final String userKey = Constants.userKey;
  final String apiKey = Constants.apiKey;
  // final http.Client httpClient;

  // ApiServices({@required this.httpClient}):assert(httpClient !=null);


   Future userLogin(String email,String password) async{
     var mapData = new Map<String, String>();
     mapData['user'] = '${userKey}';
     mapData['key'] = '${apiKey}';
     mapData['email'] = '${email}';
     mapData['Pwd'] = '${password}';

     Response response = await http.post('${Constants.baseURL}login.php',body: mapData);

    if(response.statusCode == 200){
      final result = json.decode(response.body);
      return result;

    }

    else{
      return null;
    }

  }

  Future getSchemeList() async{
    var schemeData = new Map<String, String>();
    schemeData['user'] = '${userKey}';
    schemeData['key'] = '${apiKey}';

    Response response = await http.post('${Constants.baseURL}list.php',body:schemeData);

    print('this is the result response : ${response.body}');
    if(response.statusCode == 200){
      final result = json.decode(response.body);
      return SchemeModel.fromJson(result);

    }

    else{
      return null;
    }

  }


  Future getOrderList() async{
    var schemeData = new Map<String, String>();
    schemeData['user'] = '${userKey}';
    schemeData['key'] = '${apiKey}';
    schemeData['userId'] = '118';

    Response response = await http.post('${Constants.baseURL}orders.php',body:schemeData);

    print('this is the result response : ${response.body}');
    if(response.statusCode == 200){
      final result = json.decode(response.body);
       return OrderModel.fromJson(result);

    }

    else{
      return null;
    }

  }

  Future getSchemeDetails(String id) async{
    var detailData = new Map<String, String>();
    detailData['user'] = '${userKey}';
    detailData['key'] = '${apiKey}';
    detailData['schemeCode'] = '${id}';
    print('this is map data : ${detailData}');

    Response response = await http.post('${Constants.baseURL}detail.php',body:detailData);

    print('this is the result response : ${response.body}');
    if(response.statusCode == 200){
      final result = json.decode(response.body);

      return SchemeDetailsModel.fromJson(result);
    }

    else{
      return null;
    }

  }

  Future placeOrder(String id,String orderAmount) async{
    var orderData = new Map<String, String>();
    orderData['user'] = '${userKey}';
    orderData['key'] = '${apiKey}';
    orderData['userId'] = '118';
    orderData['schemeCode'] = '${id}';
    orderData['orderAmt '] = '${orderAmount}';
    print('this is map data : ${orderData}');

    Response response = await http.post('${Constants.baseURL}placingorder.php',body:orderData);

    print('this is the result response : ${response.body}');
    if(response.statusCode == 200){
      final result = json.decode(response.body);

      return result;
    }

    else{
      return null;
    }

  }
}

