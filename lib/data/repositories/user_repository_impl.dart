import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/contracts/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  static const String _userKey='userData';


  @override
  Future<void> saveUserData(String userData) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_userKey, userData);
  }

  @override
  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
  @override
  Future<String?> getUserData() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userKey);
  }

  @override
  Future<String?> getToken() async
  {
    final preferences = await SharedPreferences.getInstance();
    String? userStr=preferences.getString(_userKey);
    try{
      final Map<String,dynamic> extractedUserData = json.decode(userStr!) as Map<String,dynamic>;
      String? token=extractedUserData["token"];
      return token;
    }
    catch(error)
    {
      print(error.toString());
    }
    return null;



  }



}