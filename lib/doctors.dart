import 'package:flutter/cupertino.dart';

class Doctors {
  static List<dynamic> doctors = [];
  String id;
  String firstName;
  String speciality;
  String profilePicture;
  Image image;

  Doctors(this.id, this.firstName, this.speciality, this.profilePicture,
      this.image);
}
