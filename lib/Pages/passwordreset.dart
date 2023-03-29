

import 'package:cat_1/Pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:cat_1/widgets/mywidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class passwordreset extends StatefulWidget {
  const passwordreset({Key? key}) : super(key: key);

  @override
  _passwordresetState createState() => _passwordresetState();
}

class _passwordresetState extends State<passwordreset> {

  TextEditingController userName = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Colors.grey,
    body: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    TextField(
    controller: userName,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.person_add_alt),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(80.0),
    ),

    labelText: 'Enter a valid username',
    ),
    ),
      const SizedBox(
        height: 15,
      ),

      ElevatedButton(

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()));
        },
        child: Text("OK"),
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          onPrimary: Colors.white,
          maximumSize: const Size(300, 50),
          minimumSize: const Size(300, 50),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(80.0),
          ),
        ),
      ),
    ],
    ),
    ),
    );
  }

  void retrievePasswordFunction() {
    if (userName.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar("Provide Username"),
      );
      return;
    } else {

      retrievePassword(userName.text);
    }
  }

  retrievePassword(String userName) async {
    DialogBuilder(context).showLoadingIndicator(
        "Please wait as we Retrieve your password", "Retrieving");
    Map data = {'username': userName};
    var jsonResponse;
    var response = await http.post(
        Uri.parse("https://keamshoppingstore.000webhostapp.com/retreivePassword.php"),
        body: data);
    //use shared preferences to store username
    //in the shared preferences we can store the name
    if (response.statusCode == 200) {

      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          DialogBuilder(context).hideOpenDialog();
        });
        int isRegistered = jsonResponse['code'];
        var retreivedPassword = jsonResponse['password'];

        if (isRegistered == 1) {
          _showBottomSheet(context, retreivedPassword);

        } else {
          //wrong password use SnackBar to Show
          scaffoldMessenger.showSnackBar(
            mySnackBar("Wrong Credentials"),
          );
        }
      }
    } else {
      setState(() {
        DialogBuilder(context).hideOpenDialog();
      });
    }
  }

  _showBottomSheet(context, String message){
    showModalBottomSheet(context: context, builder: (BuildContext c){
      return Container(
        height: MediaQuery.of(context).size.height*0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Password Retrieved", style: TextStyle(
                fontFamily: "Cambria", color: Colors.grey,
              ),),
            ),

            Divider(
              height: 2.0,
            ),

            ListTile(
              title: Text("Your password has been Retrieved BELOW!!! ",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),

            Divider(
              height: 2.0,
            ),

            ListTile(
              title: Text("Make sure you change it on your Accounts settings once you log in!!!",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Divider(
              height: 2.0,
            ),

            ListTile(
              title: Text("Password : $message",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),

            Divider(
              height: 2.0,
            ),

            _botomButton(label: "Go to Login", onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Login()));
            }, clr: Colors.blue, context: context),

          ],
        ),
      );
    });
  }

  _botomButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  })
  {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose==true?Colors.grey[300]!:clr
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
