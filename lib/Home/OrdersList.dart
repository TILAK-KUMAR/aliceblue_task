import 'package:aliceblue_task/Home/OrderModel.dart';
import 'package:aliceblue_task/Services/ApiServices.dart';
import 'package:aliceblue_task/Utils/Constants.dart';
import 'package:aliceblue_task/Utils/MyColors.dart';
import 'package:aliceblue_task/Utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


import 'HomeScreen.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {

  OrderModel _orderModel;
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!Constants.socialLogin){
      getOrders();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Constants.socialLogin? showWebView():Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.toolbarBlue,
          elevation: 5.0,
          centerTitle: true,
          title: Text('Orders List',style: TextStyle(fontSize: 18,color: MyColors.colorwhite),),
        ),
      body:_loading?Loader():ListView.builder(
        itemCount: 1,
          itemBuilder:(BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Scheme : ${_orderModel.data.schemeCode}',style: TextStyle(
                            fontWeight: FontWeight.w600,color: MyColors.colorBlack,
                            fontSize: 18
                        ),),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: Text('${_orderModel.data.orderDate}',style: TextStyle(
                              fontWeight: FontWeight.w100,color: Colors.grey,
                              fontSize: 16
                          ),),
                        )
                      ],
                    ),
                    Text('Rs.${_orderModel.data.orderAmount}',style: TextStyle(
                      fontWeight: FontWeight.w600,color: MyColors.buttonColor,
                      fontSize: 20
                    ),)
                  ],
                ),
              ),
            ),
          );
          })
    );
  }

  getOrders()async {
    setState(() {
      _loading = true;
    });

      var res = await ApiServices().getOrderList();
      setState(() {
        _loading = false;
        _orderModel = res;
      });


    // print('this is the result for orders : ${data}');
  }
  Widget showWebView()=>SafeArea(
    child: Expanded(
      child: WebView(
        initialUrl: 'https://leads.aliceblueonline.com/ANTAPI/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ),
  );

}
