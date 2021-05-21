import 'package:aliceblue_task/Home/SchemeModel.dart';
import 'package:aliceblue_task/SchemeDetails/SchemeDetails.dart';
import 'package:aliceblue_task/Services/ApiServices.dart';
import 'package:aliceblue_task/Utils/Constants.dart';
import 'package:aliceblue_task/Utils/MyColors.dart';
import 'package:aliceblue_task/Utils/Widgets.dart';
import 'package:flutter/material.dart';

class SchemeLists extends StatefulWidget {
  @override
  _SchemeListsState createState() => _SchemeListsState();
}

class _SchemeListsState extends State<SchemeLists> {
  SchemeModel schemeModel;
  List searchSchemeModel=[];
  bool _loading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSchemes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.toolbarBlue,
        elevation: 5.0,
        centerTitle: true,
        title: Text('Scheme List',style: TextStyle(fontSize: 18,color: MyColors.colorwhite),),
      ),
        drawer: NavDrawer(),
        body: _loading?Loader():ListView.builder(
          itemCount: schemeModel.data.length,
          itemBuilder:(BuildContext context,int index){

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 6,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${schemeModel.data[index].schemeName}',style: TextStyle(
                          fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.colorBlack
                      ),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:4.0),
                        child: Text('Scheme Type : ${schemeModel.data[index].schemeType}',style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.colorBlack
                        ),),
                      ),
                      schemeRow(index)

                    ],
                  ),
                ),
              ),
            );

          })
    );



  }



  Widget schemeRow(int index) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Navrs : ${schemeModel.data[index].navrs}',style: TextStyle(
              fontSize: 14,fontWeight: FontWeight.w300,color: MyColors.colorBlack
          ),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Text('Min. Investment : ${schemeModel.data[index].minInv}',style: TextStyle(
                fontSize: 14,fontWeight: FontWeight.w300,color: MyColors.colorBlack
            ),),
          ),
        ],
      ),
      viewDetailsButton(index)
    ],
  );


  Widget viewDetailsButton(int i)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: RaisedButton(
      color: MyColors.buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SchemeDetails(schemeId:schemeModel.data[i].schemecode),
          ), //MaterialPageRoute
        );
      },
      child: Text('${Constants.details}',style: TextStyle(
          color: MyColors.colorwhite,fontSize: 16
      ),),
    ),
  );

  getSchemes()async {
    setState(() {
      _loading = true;
    });
    var result = await ApiServices().getSchemeList();
    setState(() {
      _loading = false;
      schemeModel = result;

    });
  }

  // Widget searchBar() =>Container(
  //   width: MediaQuery.of(context).size.width-100,
  //   height: 30,
  //   decoration: BoxDecoration(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //   ),
  //   child: Center(
  //     child: Padding(
  //       padding: const EdgeInsets.only(left:8.0),
  //       child: TextFormField(
  //
  //         keyboardType: TextInputType.emailAddress,
  //         controller: searchController,
  //         cursorColor: MyColors.colorBlack,
  //         cursorWidth: 1,
  //         style: TextStyle(fontSize: 14,color: MyColors.colorBlack, fontWeight: FontWeight.w300),
  //         textAlign: TextAlign.start,
  //         decoration: InputDecoration(
  //             suffixIcon: IconButton(
  //               onPressed: (){},
  //               icon: Icon(Icons.search),
  //             ),
  //             border: InputBorder.none,
  //             enabledBorder: InputBorder.none,
  //             focusedBorder: InputBorder.none,
  //             hintText: 'Search by Scheme Name '
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}
