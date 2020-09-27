import 'package:flutter/material.dart';
import 'package:untitled/dashboardPage.dart';

class SecondPage extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(128, 128, 128, 1),
          title: Text("Code confirmation"),
        ),
        body: buildSecondHomePage(context));
  }

  Widget buildSecondHomePage(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter the code',
                style: TextStyle(
                    fontSize: 17, color: Color.fromRGBO(64, 64, 64, 1))),
            Container(
              margin: const EdgeInsets.all(20),
              width: 300,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(64, 64, 64, 1),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Column(children: <Widget>[
                  Container(
                    width: 1000.0,
                    child: TextField(
                      controller: myController,
                      maxLength: 6,
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Color.fromRGBO(64, 64, 64, 1))),
                          labelText: 'Code'
                          // errorText: _validate ? 'fill the box' : null,
                          ),
                    ),
                  ),
                ]),
              ),
            ),
            buildDoneButton(context),
          ]),
    );
  }

  Widget buildDoneButton(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashBoardPage()),
        );
      },
      elevation: 2.0,
      fillColor: Color.fromRGBO(160, 160, 160, 1),
      child: Text(
        "Done",
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color.fromRGBO(64, 64, 64, 1))),
    );
  }
}
