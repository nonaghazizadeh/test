import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/dashboardPage.dart';
import 'package:untitled/doctors.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Add doctor",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class AddDoctorPage extends StatefulWidget {
  final String title;

  AddDoctorPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddDoctor();
}

class AddDoctor extends State<AddDoctorPage> {
  final TextEditingController nameTextField = TextEditingController();
  final TextEditingController specialityTextField = TextEditingController();
  final TextEditingController photoURLTextField = TextEditingController();
  Image image;

  @override
  void dispose() {
    nameTextField.dispose();
    specialityTextField.dispose();
    photoURLTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(128, 128, 128, 1),
        title: Text('Add doctor page'),
      ),
      body: addDoctorPage(),
    );
  }

  void getNameTextField() async {
    var name = nameTextField.text;
    final SharedPreferences nameSharedPreferences =
        await SharedPreferences.getInstance();
    nameSharedPreferences.setString("name", name);
  }

  void getSpecialityTextField() async {
    var speciality = specialityTextField.text;
    final SharedPreferences specialitySharedPreferences =
        await SharedPreferences.getInstance();
    specialitySharedPreferences.setString("speciality", speciality);
  }

  void getPhotoURl() async {
    var photoURL = photoURLTextField.text;
    final SharedPreferences photoURLSharedPreferences =
        await SharedPreferences.getInstance();
    photoURLSharedPreferences.setString("profilePicture", photoURL);
  }

  Widget addDoctorPage() {
    return Center(
        child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          alignment: Alignment.topLeft,
          child: Text('Enter your information',
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(64, 64, 64, 1))),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextField(
            controller: nameTextField,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide:
                      new BorderSide(color: Color.fromRGBO(64, 64, 64, 1))),
              labelText: 'Name ',
              // errorText: _validate ? 'fill the box' : null,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextField(
            controller: specialityTextField,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide:
                      new BorderSide(color: Color.fromRGBO(64, 64, 64, 1))),
              labelText: 'Speciality ',
              // errorText: _validate ? 'fill the box' : null,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextField(
            controller: photoURLTextField,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide:
                      new BorderSide(color: Color.fromRGBO(64, 64, 64, 1))),
              labelText: 'URL ',
              // errorText: _validate ? 'fill the box' : null,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: FloatingActionButton(
            child: Icon(Icons.open_in_browser),
            onPressed: () async {
              final _image = await FlutterWebImagePicker.getImage;
              setState(() {
                image = _image;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: RaisedButton(
            onPressed: () {
              getNameTextField();
              getSpecialityTextField();
              getPhotoURl();

              var doctor = {
                'id': generateRandomId(),
                'firstName': nameTextField.text,
                'speciality': specialityTextField.text,
                'profilePicture': null,
                'image': image
              };
              Doctors.doctors.add(doctor);

              // DashBoard.addDoctorToList();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashBoardPage()));
              print(Doctors.doctors);
            },
            color: Color.fromRGBO(114, 117, 120, 1),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            child: Text("Save",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
          ),
        )
      ],
    ));
  }

  static int generateRandomId() {
    Random random = new Random();
    var id = random.nextInt(1000);
    return id;
  }

// void getName() async {
//   final SharedPreferences nameSharedPreferences =
//   await SharedPreferences.getInstance();
//   name = nameSharedPreferences.getString("name");
//   setState(() {});
// }
//
// void getSpeciality() async {
//   final SharedPreferences specialitySharedPreferences =
//   await SharedPreferences.getInstance();
//   speciality = specialitySharedPreferences.getString("speciality");
//   setState(() {});
// }
//
// void getPhotoURL() async {
//   final SharedPreferences photoURLShredPreferences =
//   await SharedPreferences.getInstance();
//   photoURL = photoURLShredPreferences.getString("photoURL");
//   setState(() {});
// }
}
