import 'dart:convert' show json;
import 'package:cat_1/widgets/mywidgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {
  String message = "";
  TextEditingController fName = TextEditingController();
  TextEditingController sName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                //image asset
                TextField(
                  controller: fName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_add_alt),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    labelText: 'First Name',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: sName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_add_alt),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    labelText: 'Second Name',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: passwordConfirm,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    labelText: 'Confirm Password',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                customButton(() {
                  regFunction();
                }, "REGISTER"),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('LOGIN $message'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()));
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void regFunction() {
    if (fName.text.isEmpty &&
        sName.text.isEmpty &&
        userName.text.isEmpty &&
        password.text.isEmpty &&
        passwordConfirm.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Credentials"),
      );
      return;
    } else if (fName.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Enter Firstname"),
      );
      return;
    } else if (sName.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Enter SecondName"),
      );
    } else if (userName.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Enter Username"),
      );
    } else if (password.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Enter password"),
      );
    } else if (passwordConfirm.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Confirm password"),
      );
    } else {

      print(fName.text);
      print(sName.text);
      print(userName.text);
      print(password.text);


      signIn(fName.text, sName.text, userName.text, password.text);
    }
  }

  signIn(String fName, String sName, String userName, String password) async {
    DialogBuilder(context).showLoadingIndicator(
        "Please wait as we authenticate you", "Authentication");
    Map data = {
      'fname': fName,
      'sname': sName,
      'username': userName,
      '_password': password
    };
    var jsonResponse;
    var response = await http.post(
        Uri.parse("https://keamshoppingstore.000webhostapp.com/signup.php"),
        body: data);
    print(data);
    print(response.body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          DialogBuilder(context).hideOpenDialog();
        });
        int isRegistered = jsonResponse['code'];
        if (isRegistered == 1) {
          scaffoldMessenger.showSnackBar(
            mySnackBar("Account Created"),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const Login()),
          );
          //use shared preferences to store user's username and firstname
          //Hey Timothy
        } else {
          scaffoldMessenger.showSnackBar(
            mySnackBar("Username already in Use"),
          );
        }
      }
    } else {
      setState(() {
        DialogBuilder(context).hideOpenDialog();
      });
    }
  }
}
