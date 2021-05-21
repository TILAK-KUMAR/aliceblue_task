
import 'package:aliceblue_task/Home/HomeScreen.dart';
import 'package:aliceblue_task/Login/google_signin_provider.dart';
import 'package:aliceblue_task/Services/ApiServices.dart';
import 'package:aliceblue_task/Services/Preferences.dart';
import 'package:aliceblue_task/Utils/Authentication.dart';
import 'package:aliceblue_task/Utils/Constants.dart';
import 'package:aliceblue_task/Utils/MyColors.dart';
import 'package:aliceblue_task/Utils/Widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailCntrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _loading = false;


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.toolbarBlue,
      appBar: AppBar(
       elevation: 0.0,
        backgroundColor: MyColors.toolbarBlue,
      ),
      body: Padding(
        key: _formkey,
        padding: const EdgeInsets.symmetric(horizontal: 44.0),
        child: _loading?Loader():Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text('${Constants.login}',style: TextStyle(
                  fontSize: 28,color: MyColors.colorwhite
              ),),
            ),
            emailField(),
            passwordField(),
            loginButton(),
            SizedBox(height: 20,),
            Text('Login with Social Media Account',style: TextStyle(fontSize: 14,color: MyColors.colorwhite),),
            SizedBox(height: 20,),
            googleSigninButton(context)
          ],
        ),
      ),
    );
  }


  Widget emailField()=>TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: emailCntrl,
    cursorColor: MyColors.colorwhite,
    cursorWidth: 1,
    style: TextStyle(fontSize: 14,color: MyColors.colorwhite,fontWeight: FontWeight.w300),
    decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorwhite)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorwhite)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorwhite)),
        hintText: Constants.password_hint
    ),
  );

  Widget passwordField()=>TextFormField(
    obscureText: true,
    controller: passwordCtrl,
    cursorColor: MyColors.colorwhite,
    cursorWidth: 1,
    style: TextStyle(fontSize: 14,color: MyColors.colorwhite,fontWeight: FontWeight.w300),
    decoration: InputDecoration(
      border: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorwhite)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorwhite)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorwhite)),
      hintText: Constants.password_hint,
    ),
  );

  Widget loginButton()=>Padding(
    padding: const EdgeInsets.symmetric(vertical:28.0,horizontal: 20.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: MyColors.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          validateCred();
        },
        child: Text('${Constants.login}',style: TextStyle(
            color: MyColors.colorwhite,fontSize: 18
        ),),
      ),
    ),
  );



  Widget googleSigninButton(BuildContext context)=>Padding(
    padding: const EdgeInsets.symmetric(vertical:22.0,horizontal: 20.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: MyColors.colorwhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          getGoogleUserDetails();
        },
        child: Row(

          children: <Widget>[
            Image.asset('assets/google.png',height: 20.0,width: 20.0,),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Text('${Constants.google_login}',style: TextStyle(
                  color: MyColors.toolbarBlue,fontSize: 18
              ),),
            ),
          ],
        ),
      ),
    ),
  );


  showToast(String message){

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: MyColors.colorwhite,
        fontSize: 16.0
    );
  }

  void validateCred() async{
    if(EmailValidator.validate(emailCntrl.text) && passwordCtrl.text.toString().isNotEmpty){

      setState(() {
        _loading = true;
      });
      var data = await ApiServices().userLogin(emailCntrl.text, passwordCtrl.text);

      if(data['Status'].toString()=='Failure'){
        showToast('${data['Message']}');
        setState(() {
          _loading = false;
        });
      }
      else{
        Constants.userID = data['Data']['UserId'];
        Constants.userName = data['Data']['name'];
        Constants.userMailID = data['Data']['emailId'];
        Constants.socialLogin = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ), //MaterialPageRoute
        );
        setState(() {
          _loading = false;
        });
      }
    }
    else{
      showToast(Constants.valid_creds);
    }
  }


  getGoogleUserDetails() async{
    setState(() {
      _loading = true;
    });

    User user = await Authentication.signInWithGoogle(context: context);
    setState(() {
      if(user!=null){
        Constants.userName = user.displayName;
        Constants.userMailID = user.email;
        Constants.socialLogin = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ), //MaterialPageRoute
        );
      }
      else{
        showToast('User Not Found');
      }
      _loading = false;
    });

  }

}
