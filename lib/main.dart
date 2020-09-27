import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/loadingPage.dart';
import 'package:untitled/secondPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login form',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'persian'),
      home: LoadingPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(128, 128, 128, 1),
          title: Text(widget.title),
        ),
        body: buildHomePage());
  }

  void _check(BuildContext context) async {
    isLoading = true;
    setState(() {});

    var phoneNumber = myController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("phone_number", phoneNumber);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );

    if (phoneNumber.startsWith("0")) {
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       // Retrieve the text the user has entered by using the
      //       // TextEditingController.
      //       content: Text("correct"),
      //     );
      //   },
      // );

      Builder(
        builder: (BuildContext context) {
          return SnackBar(
            content: Text('correct'),
            duration: Duration(seconds: 3),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // Retrieve the text the user has entered by using the
            // TextEditingController.
            content: Text("it should start with 0"),
          );
        },
      );
    }
  }

  Widget buildHomePage() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your phone number',
              style:
                  TextStyle(fontSize: 17, color: Color.fromRGBO(64, 64, 64, 1)),
            ),
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
                      cursorColor: Color.fromRGBO(0, 0, 51, 1),
                      controller: myController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(64, 64, 64, 1))),
                        hintText: 'Phone number',
                        // errorText: _validate ? 'fill the box' : null,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            isLoading ? buildProgressBar() : buildNextButton(),
          ]),
    );
  }

  Widget buildProgressBar() {
    return CircularProgressIndicator(
      valueColor:
          new AlwaysStoppedAnimation<Color>(Color.fromRGBO(0, 0, 51, 1)),
    );
  }

  Widget buildNextButton() {
    return RawMaterialButton(
      onPressed: () {
        _check(context);
      },
      elevation: 2.0,
      fillColor: Color.fromRGBO(160, 160, 160, 1),
      child: Text(
        "Next",
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color.fromRGBO(64, 64, 64, 1))),
    );
  }
}
