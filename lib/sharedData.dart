import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SharedData {
  static var currentMenu = "menu_1";

  static List<MenuItems> menuItems = [
    MenuItems("Home",
        Icon(Icons.home, size: 22, color: Color.fromRGBO(64, 64, 64, 1))),
    MenuItems("Account",
        Icon(Icons.person, size: 22, color: Color.fromRGBO(64, 64, 64, 1))),
    MenuItems("Time",
        Icon(Icons.timer, size: 22, color: Color.fromRGBO(64, 64, 64, 1))),
    MenuItems(
        "Phone",
        Icon(
          Icons.add_call,
          size: 22,
          color: Color.fromRGBO(64, 64, 64, 1),
        )),
  ];
}

class MenuItems {
  String text;
  Icon icon;

  MenuItems(String text, Icon icon) {
    this.text = text;
    this.icon = icon;
  }
}
