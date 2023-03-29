import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Widget myLabel(String label,
    {double size = 15, Color textColor = Colors.purple}) {
  return (Text(
    label,
    style:
        TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w800),
  ));
}

Widget myTextfield(String hint, TextEditingController con) {
  return (TextField(
    controller: con,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hint,
    ),
  ));
}

Widget myButton(String label, VoidCallback action) {
  return ElevatedButton(onPressed: () {}, child: Text(label));
}

Widget customButton(Function() action, label) {
  return ElevatedButton(
    onPressed: action,
    child: Text(label),
    style: ElevatedButton.styleFrom(
      primary: Colors.blueGrey,
      onPrimary: Colors.white,
      maximumSize: const Size(300, 50),
      minimumSize: const Size(300, 50),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(80.0),
      ),
    ),
  );
}

SnackBar mySnackBar(String message) {
  return SnackBar(
      backgroundColor: Colors.cyanAccent,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: snackText(),
      ));
}

snackText() {}

//add this class to mywidgets, we will use it for Progress Bar
class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator(String text, String header) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.deepOrange,
              content: LoadingIndicator(text: text, header: header),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({this.text = '', this.header = ''});

  final String text;
  final String header;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;
    var headerText = header;
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context, headerText),
              _getText(displayedText)
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.deepOrange,
            ),
            width: 32,
            height: 32),
        padding: const EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context, String headerText) {
    return Padding(
        child: Text(
          headerText,
          textAlign: TextAlign.center,
        ),
        padding: const EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      textAlign: TextAlign.center,
    );
  }
}
class Prefs {

  Future addStringToSF (String key, String val) async {

    SharedPreferences prefs= await SharedPreferences.getInstance();
    await prefs.setString (key, val);

  }

  Future<String?> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final image = prefs.getString(key);
    return image;
  }

  Future addBooleanToSF (String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, val);
  }
}
