import 'package:flutter/material.dart';

class User {

  final String name;
  String password;
  String phone;
  String gender;

  User({required this.name,required this.password, required this.phone, this.gender='female'});

}
class UserRepository {
  static List<User> users = [];
}
