import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfmemory_flutter/api/user.api.dart';
import 'package:selfmemory_flutter/models/signup.model.dart';
import 'package:selfmemory_flutter/models/user.dart';
import 'package:selfmemory_flutter/views/login.dart';

class SignupPage extends StatefulWidget {
  static String tag = 'signup-page'; //for routes

  @override
  _SignupPagePageState createState() => _SignupPagePageState();
}

class _SignupPagePageState extends State<SignupPage> {
  TextEditingController fisrtname_controller = TextEditingController();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  var _showCircularProgressIndicator = false;

  @override
  initState() {}

  //add login method
  Future<User> signup(
      String email, String password, String firstname, String lastname) async {
    if (email.length > 0 &&
        password.length > 0 &&
        firstname.length > 0 &&
        lastname.length > 0) {
      setState(() {
        _showCircularProgressIndicator = true;
      });
      SignupModel data = SignupModel(
          email: email,
          password: password,
          firstname: firstname,
          lastname: lastname);
      var result = await signupApi(data);
      if (result != null) {
        setState(() {
          _showCircularProgressIndicator = false;
        });
        Navigator.of(context).pushNamed(LoginPage.tag);
        Fluttertoast.showToast(
            msg: "Registro correcto, Ingresa a Self Memory!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[600],
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        setState(() {
          _showCircularProgressIndicator = false;
        });
        Fluttertoast.showToast(
            msg: "Error al registrar, intenta con otro email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[600],
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } else {
      Fluttertoast.showToast(
          msg: "Error al registrar, Faltan Datos!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[600],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 40.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: email_controller,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: password_controller,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final firstname = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: fisrtname_controller,
      decoration: InputDecoration(
        hintText: 'Nombre',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final lastname = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: lastname_controller,
      decoration: InputDecoration(
        hintText: 'Apellido',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[700], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          this.signup(email.controller.text, password.controller.text,
              firstname.controller.text, lastname.controller.text);
        },
        child: Text('Registrar', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[400], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          Navigator.pop(context); //POP
        },
        child: Text('Volver', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            Text("SELFMEMORY",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blueGrey)),
            SizedBox(height: 18.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            firstname,
            SizedBox(height: 8.0),
            lastname,
            SizedBox(height: 24.0),
            signupButton,
            backButton,
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _showCircularProgressIndicator
                    ? CircularProgressIndicator()
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
