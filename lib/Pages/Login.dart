import 'package:cat_1/widgets/mywidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cat_1/Pages/registration.dart';
import 'package:cat_1/Pages/passwordreset.dart';
import 'package:cat_1/Pages/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image:  AssetImage("assets/grad.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              customButton(()
              {
                loginFunction();
              }
              , "Sign In"),
              const SizedBox(
                height: 15,
              ),
              customButton(()

              {
                loginFunction();
                Navigator.push(context,MaterialPageRoute(builder: (context) => const dashboard()));

              }
                  , "Continue As Guest"),
              const SizedBox(
                height: 15,
              ),
              customButton(()

              {
                loginFunction();
                Navigator.push(context,MaterialPageRoute(builder: (context) => const passwordreset()));

              }
                  , "Forgot Password"),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Registration()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginFunction() {
    if (userName.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Enter Username"),
      );
      return;
    } else if (password.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Enter password"),
      );
      return;
    } else {
      signIn(userName.text, password.text);
    }
  }

  signIn(String userName, password) async {
    DialogBuilder(context).showLoadingIndicator(
        "Please wait as we authenticate you", "Authentication");
    Map data = {'username': userName, 'password': password};
    var jsonResponse;
    var response = await http.post(
        Uri.parse("https://keamshoppingstore.000webhostapp.com/login.php"),
        body: data);
    print(response.body);
    print(data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          DialogBuilder(context).hideOpenDialog();
        });
        int isRegistered = jsonResponse['code'];
        if (isRegistered == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const dashboard()),
          );


        } else {
          scaffoldMessenger.showSnackBar(
            mySnackBar("Wrong Password"),
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
