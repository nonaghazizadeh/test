import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/addDoctor.dart';
import 'package:untitled/sharedData.dart';

import 'doctors.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DashBoard page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashBoardPage(title: 'DashBoard page'),
    );
  }
}

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  DashBoard createState() => DashBoard();
}

class DashBoard extends State<DashBoardPage> {
  final myController = TextEditingController();
  static var phoneNumber = "loading";
  static var name = "loading";
  static var speciality = "loading";
  static var photoURL = "loading";

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.height < 815 && size.width < 380) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(128, 128, 128, 1),
            title: Text('DashBoard page'),
          ),
          body: dashboardPageForIphone(),
          drawer: sideBarForIphone(),
        ),
      );
    } else {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(128, 128, 128, 1),
              title: Text('DashBoard page'),
              automaticallyImplyLeading: false,
            ),
            body: dashboardPageForWeb()),
      );
    }
  }

  void getItems() async {
    Response response = await get(
        "https://api.symoteb.ir/v1/?json=%7B%22request%22:400011,%22doctor%22:%7B%7D,%22client%22:%7B%22appName%22:%22SymoTeb%22%7D%7D");
    setState(() {
      var doctors = json.decode(utf8.decode(response.bodyBytes));
      var doctorsJson = doctors['doctorsList'];
      Doctors.doctors.addAll(doctorsJson);
    });
  }

  void loadData() async {
    if (phoneNumber == "loading") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      phoneNumber = prefs.getString("phone_number");
      setState(() {});
    }
  }

  Future getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString("phone_number");
    Future.delayed(Duration(seconds: 1), () => phoneNumber);
    return phoneNumber;
  }

  Widget dashboardPageForIphone() {
    loadData();
    return Center(
        child: Container(
      color: Color.fromRGBO(245, 248, 251, 1),
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(children: <Widget>[
                Container(
                    margin:
                        EdgeInsets.only(top: 10, bottom: 0, left: 25, right: 8),
                    child: Text(
                      'List of doctors',
                      style: TextStyle(
                          fontSize: 28,
                          color: Color.fromRGBO(67, 88, 143, 1),
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(
                  flex: 1,
                ),
                Container(
                    margin:
                        EdgeInsets.only(top: 10, bottom: 0, left: 5, right: 25),
                    // width: 150,
                    child: Container(
                        height: 40, child: buildAddNewRecordButton())),
              ]),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Card(
                  margin:
                      EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 5),
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: setTopMenuBar(),
                      ),
                      Divider(
                        thickness: 2,
                        color: Color.fromRGBO(224, 224, 224, 1),
                      ),
                      buildMenuPage(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget sideBarForIphone() {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          color: Color.fromRGBO(193, 195, 199, 1),
          child: DrawerHeader(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                return ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 24,
                  ),
                  title: Text(
                    snapshot.data,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          child: (ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: SharedData.menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    splashColor: Color.fromRGBO(153, 204, 255, 1),
                    hoverColor: Color.fromRGBO(238, 245, 255, 1),
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(5),
                            height: 50,
                            child: ListTile(
                              leading: SharedData.menuItems[index].icon,
                              title: Text(
                                "${SharedData.menuItems[index].text}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )),
                      ],
                    ));
              })),
        ),
      ],
    ));
  }

  Widget dashboardPageForWeb() {
    loadData();
    return Center(
      child: Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Card(
                      margin: EdgeInsets.all(15),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 24,
                        ),
                        title: Text(phoneNumber),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    color: Color(0xD3D3D3),
                    child: Card(color: Colors.white, child: sideBarForWeb()),
                  ),
                ),
              ],
            ),
          ),
          new Expanded(
            flex: 4,
            child: Container(
              // margin: new EdgeInsets.all(10),
              // color: Color(0xefefef),
              color: Color.fromRGBO(245, 248, 251, 1),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                top: 10, bottom: 0, left: 25, right: 8),
                            width: 200,
                            child: Text(
                              'List of doctors',
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Color.fromRGBO(67, 88, 143, 1),
                                  fontWeight: FontWeight.bold),
                            )),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 10, bottom: 0, left: 5, right: 25),
                            // width: 150,
                            child: Container(
                                height: 40, child: buildAddNewRecordButton())),
                      ]),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Card(
                          margin: EdgeInsets.only(
                              left: 15, top: 0, right: 15, bottom: 5),
                          color: Color.fromRGBO(255, 255, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: setTopMenuBar(),
                              ),
                              Divider(
                                thickness: 2,
                                color: Color.fromRGBO(224, 224, 224, 1),
                              ),
                              buildMenuPage(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideBarForWeb() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: SharedData.menuItems.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            splashColor: Color.fromRGBO(153, 204, 255, 1),
            hoverColor: Color.fromRGBO(238, 245, 255, 1),
            onTap: () {},
            child: Container(
                margin: EdgeInsets.all(5),
                height: 50,
                child: ListTile(
                  leading: SharedData.menuItems[index].icon,
                  title: Text(
                    "${SharedData.menuItems[index].text}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )),
          );
        });
  }

  Widget buildAddNewRecordButton() {
    return RaisedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDoctorPage()));
        },
        color: Color.fromRGBO(100, 93, 246, 1),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.add, color: Color.fromRGBO(255, 255, 255, 1)),
            Text("Add record",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold))
          ],
        ));
  }

  Widget setTopMenuBar() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: new EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: Text('Image',
                      style: TextStyle(
                          color: Color.fromRGBO(128, 128, 128, 1),
                          fontSize: 14)),
                ),
                new Expanded(
                  flex: 2,
                  child: Text('ID',
                      style: TextStyle(
                          color: Color.fromRGBO(128, 128, 128, 1),
                          fontSize: 14)),
                ),
                new Expanded(
                  flex: 2,
                  child: Text('Name',
                      style: TextStyle(
                          color: Color.fromRGBO(128, 128, 128, 1),
                          fontSize: 14)),
                ),
                new Expanded(
                  flex: 2,
                  child: Text('Speciality',
                      style: TextStyle(
                          color: Color.fromRGBO(128, 128, 128, 1),
                          fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static int generateRandomId() {
    Random random = new Random();
    var id = random.nextInt(1000);
    return id;
  }

  static void addDoctorToList() async {
    if (name != null) {
      final SharedPreferences nameSharedPreferences =
          await SharedPreferences.getInstance();
      name = nameSharedPreferences.getString("name");
    }

    if (speciality != null) {
      final SharedPreferences specialitySharedPreferences =
          await SharedPreferences.getInstance();
      speciality = specialitySharedPreferences.getString("speciality");
    }

    if (photoURL != null) {
      final SharedPreferences photoURLShredPreferences =
          await SharedPreferences.getInstance();
      photoURL = photoURLShredPreferences.getString("profilePicture");
    }

    var doctor = {
      'id': generateRandomId(),
      'firstName': name,
      'speciality': speciality,
      'profilePicture': photoURL,
    };
    Doctors.doctors.add(doctor);
  }
}

Widget image(int index) {
  if (Doctors.doctors[index]['image'] == null) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: 20,
        backgroundImage:
            new NetworkImage(Doctors.doctors[index]['profilePicture']),
      ),
    );
  } else {
    return Doctors.doctors[index]['image'];
  }
}

Widget buildMenu_1() {
  return Expanded(
    child: ListView.separated(
        itemCount: Doctors.doctors.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Expanded(flex: 1, child: image(index)),
                Spacer(
                  flex: 1,
                ),
                new Expanded(
                  flex: 4,
                  child: Text(Doctors.doctors[index]['id'].toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(82, 103, 157, 1))),
                ),
                new Expanded(
                  flex: 4,
                  child: Text(Doctors.doctors[index]['firstName'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(82, 103, 157, 1))),
                ),
                new Expanded(
                  flex: 4,
                  child: Text(Doctors.doctors[index]['speciality'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(82, 103, 157, 1))),
                ),
              ],
            ),
          );
        }),
  );
}

Widget buildMenu_2() {
  return Center();
}

Widget buildMenu_3() {
  return Center();
}

Widget buildMenu_4() {
  return Center();
}

Widget buildMenuPage() {
  switch (SharedData.currentMenu) {
    case ("menu_1"):
      return buildMenu_1();

    case ("menu_2"):
      return buildMenu_2();

    case ("menu_3"):
      return buildMenu_3();

    case ("menu_4"):
      return buildMenu_4();

    default:
      return Container();
  }
}
