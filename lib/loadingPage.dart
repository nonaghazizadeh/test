import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/main.dart';
import 'dashboardPage.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    loadData(context);
    return Center(
      child: CircularProgressIndicator(
        valueColor:
            new AlwaysStoppedAnimation<Color>(Color.fromRGBO(0, 0, 51, 1)),
      ),
    );
  }

  void loadData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), null);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var phoneNumber = sharedPreferences.getString("phone_number");

    if (phoneNumber == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: "home page")));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashBoardPage(title: "dash board")));
    }
  }
}
