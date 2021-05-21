import 'package:aliceblue_task/SchemeDetails/SchemeDetailsModel.dart';
import 'package:aliceblue_task/Services/ApiServices.dart';
import 'package:aliceblue_task/Utils/MyColors.dart';
import 'package:aliceblue_task/Utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SchemeDetails extends StatefulWidget {
  final String schemeId;


  const SchemeDetails({this.schemeId});
  @override
  _SchemeDetailsState createState() => _SchemeDetailsState(schemeId);
}

class _SchemeDetailsState extends State<SchemeDetails> {
  final String schemeID;
  bool _loading = false;
  int _minAmount,_maxAmount,_orderAmount;
  SchemeDetailsModel schemeDetailsModel;
  TextEditingController amountController = TextEditingController();

  _SchemeDetailsState(this.schemeID);

  @override
  void initState() {

    getSchemeDetails(schemeID);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: MyColors.toolbarBlue,
        title: Text('Scheme Details',style: TextStyle(
          fontWeight: FontWeight.w400,color: MyColors.colorwhite
        ),),
      ),
      floatingActionButton: showFab(),
      body: _loading?Loader():Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${schemeDetailsModel.data.cLASSNAME}',style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,color: MyColors.colorBlack
            ),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Text('Default Opt. : ${schemeDetailsModel.data.defaultopt}',style: TextStyle(
                  fontSize: 16,fontWeight: FontWeight.w100,color: MyColors.colorBlack
              ),),
            ),
            settlementRow(),
            ratioRow(),
            dateRow(),
            amountRow(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:12.0),
              child: Text('YEAR CRET  ',style: TextStyle(fontSize: 18,
                  color: MyColors.colorBlack,fontWeight: FontWeight.bold),),
            ),
            cretList(),
            Text('Industry Data',style: TextStyle(fontSize: 18,
                color: MyColors.colorBlack,fontWeight: FontWeight.bold),),
            Expanded(child: IndustryDataCards())

          ],
        ),
      ),
    );
  }

  Widget settlementRow() => Padding(
    padding: const EdgeInsets.symmetric(vertical:8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Settlement Type : ${schemeDetailsModel.data.sETTLEMENTTYPE}',style: TextStyle(
            fontSize: 16,fontWeight: FontWeight.w100,color: MyColors.colorBlack
        ),),
        Text('Lock-in Period : ${schemeDetailsModel.data.lockInPeriod}',style: TextStyle(
            fontSize: 16,fontWeight: FontWeight.w100,color: MyColors.colorBlack
        ),),

      ],
    ),
  );

  Widget amountRow() =>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Min. Rs.${schemeDetailsModel.data.minimumPurchaseAmount}',style: TextStyle(
          fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.buttonColor
      ),),
      Text('Max. Rs.${schemeDetailsModel.data.maximumPurchaseAmount}',style: TextStyle(
          fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.buttonColor
      ),),
    ],
  );

  Widget ratioRow() =>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Acc. Exit load : ${schemeDetailsModel.data.aCCEXITLOAD}',style: TextStyle(
          fontSize: 16,fontWeight: FontWeight.w100,color: MyColors.colorBlack
      ),),
      Text('Exp. Ratio : ${schemeDetailsModel.data.eXPRATIO}',style: TextStyle(
          fontSize: 16,fontWeight: FontWeight.w100,color: MyColors.colorBlack
      ),),
    ],
  );

  Widget dateRow() =>Padding(
    padding: const EdgeInsets.symmetric(vertical:8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Start : ${schemeDetailsModel.data.startDate}',style: TextStyle(
            fontSize: 14,fontWeight: FontWeight.w100,color: MyColors.colorBlack
        ),),
        Text('End : ${schemeDetailsModel.data.endDate}',style: TextStyle(
            fontSize: 14,fontWeight: FontWeight.w100,color: MyColors.colorBlack
        ),),
      ],
    ),
  );

  Widget cretList()=> Padding(
    padding: const EdgeInsets.symmetric(vertical:8.0),
    child: Container(
      height: 80,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('1 YEAR CRET : ${schemeDetailsModel.data.s1YEARCRET}',style: TextStyle(
                    fontSize: 16,color: MyColors.colorBlack
                  ),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('2 YEAR CRET : ${schemeDetailsModel.data.s2YEARCRET}',style: TextStyle(
                      fontSize: 16,color: MyColors.colorBlack
                  ),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('3 YEAR CRET : ${schemeDetailsModel.data.s3YEARCRET}',style: TextStyle(
                      fontSize: 16,color: MyColors.colorBlack
                  ),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('4 YEAR CRET : ${schemeDetailsModel.data.s4YEARCRET}',style: TextStyle(
                      fontSize: 16,color: MyColors.colorBlack
                  ),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('5 YEAR CRET : ${schemeDetailsModel.data.s5YEARCRET}',style: TextStyle(
                      fontSize: 16,color: MyColors.colorBlack
                  ),),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget IndustryDataCards(){

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: schemeDetailsModel.data.indusrtyData.length,
      itemBuilder:(BuildContext context,int i){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 1,
                  blurRadius: 9,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${schemeDetailsModel.data.indusrtyData[i].cOMPNAME}',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.colorBlack
                  ),),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical:4.0),
                  //   child: Text('${schemeDetailsModel.data.indusrtyData[i].sECTNAME}',style: TextStyle(
                  //       fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.colorBlack
                  //   ),),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4.0),
                    child: Text('Hold Percentage : ${schemeDetailsModel.data.indusrtyData[i].hOLDPERCENTAGE} %',style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.colorBlack
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text('AUM : ${schemeDetailsModel.data.indusrtyData[i].aUM}',style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.colorBlack
                    ),),
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }


  void getSchemeDetails(String id) async{
    setState(() {
      _loading = true;
    });
    var res = await ApiServices().getSchemeDetails(id);
    print('this is scheme details : ${res}');
    setState(() {
      schemeDetailsModel = res;
      _minAmount = int.parse(schemeDetailsModel.data.minimumPurchaseAmount);
      _maxAmount = int.parse(schemeDetailsModel.data.maximumPurchaseAmount);

      // print('this is scheme details : ${schemeDetailsModel.data.length.toString()}');
      _loading = false;
    });
  }

  Widget showFab() =>FloatingActionButton(
    onPressed: (){
      showAlertDialog(context);
    },
    elevation: 5.0,
    backgroundColor: MyColors.buttonColor,
    child: Icon(Icons.add_shopping_cart,color: MyColors.colorwhite,),
  );

  showAlertDialog(BuildContext context) {
    // Create button
    Widget placeOderButton = Center(
      child: RaisedButton(
        color: MyColors.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          validateAmount();
          Navigator.of(context).pop();
        },
        child: Text('PLACE ORDER',style: TextStyle(
            color: MyColors.colorwhite,fontSize: 16
        ),),
      ),
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter Order Amount"),
      content: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: MyColors.toolbarBlue,
        controller: amountController,
        cursorWidth: 1,
        style: TextStyle(fontSize: 14,color: MyColors.colorBlack,fontWeight: FontWeight.w300),
        decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.toolbarBlue)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.toolbarBlue)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.toolbarBlue)),
            hintText: 'Enter Order Amount'
        ),

      ),
      actions: [
        placeOderButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void validateAmount() {
    _orderAmount = int.parse(amountController.text.toString());
    if(_orderAmount>=_minAmount ){
      if(_orderAmount<=_maxAmount){
        placeOrder(_orderAmount);
      }
      else{
        showToast('Amount entered should be less than ${_maxAmount}');
      }
    }
    else{
      showToast('Amount entered should be more than ${_minAmount}');
    }
  }

  showToast(String message){

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.colorBlack,
        textColor: MyColors.colorwhite,
        fontSize: 16.0
    );
  }

  void placeOrder(int amount) async{
    setState(() {
      _loading = true;
    });
    var res = await ApiServices().placeOrder(schemeID, amount.toString());
    print('this is the place ordr result : ${res['Message']}');
    showToast('${res['Message']}');
    setState(() {
      _loading = false;
      amountController.clear();
    });
  }

}
