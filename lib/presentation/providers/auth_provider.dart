import 'dart:async';
import 'dart:convert';
import 'package:pawsible/domain/contracts/user_repository.dart';
import 'package:pawsible/domain/models/auth/auth_response.dart';
import 'package:flutter/foundation.dart';
import 'package:pawsible/domain/contracts/api_repository.dart';

import 'package:pawsible/domain/models/auth/auth.dart';
import 'package:pawsible/domain/models/auth/auth_request.dart';
import 'package:pawsible/utils/resources/data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  Auth? _auth;
  Timer? _authTimer;
  final ApiRepository _apiRepository;
  final UserRepository _userRepository;


  AuthProvider(this._apiRepository, this._userRepository);

  bool get isTokenExpired {
    print('isExpired?');
    print(_auth!.expireDate.isAfter(DateTime.now()));
    if (_auth?.expireDate != null && _auth?.token !=null) {
      if (_auth!.expireDate.isAfter(DateTime.now()))
        return false;
    }
    return true;
  }

  String? get userId {
    if (!isTokenExpired &&
        _auth?.userId != null) {
      return _auth?.userId;
    }
    return null;
  }
  DateTime? get tokenExpireDate {
    if (!isTokenExpired ) {
      return _auth?.expireDate;
    }
    return null;
  }

  String? get refreshToken {
    if (!isTokenExpired &&
        _auth?.refreshToken != null) {
      return _auth?.refreshToken;
    }
    return null;
  }


  //取得Token
  String? get token {
    //如果token沒有過期 回傳token
    /*if (_auth!=null){
      print(_auth?.expireDate);
      print( _auth!.expireDate.isAfter(DateTime.now()));
      print(  _auth?.token );
    }*/
    if (_auth?.expireDate != null &&
        _auth!.expireDate.isAfter(DateTime.now()) &&
        _auth?.token != null) {
      return _auth?.token;
    }
    return null;
  }

  //是否已經有取得驗證
  bool get isAuth {
    return token != null;
  }

  //註冊
  Future<void> signup(String email, String password) async {
    //return _authenticate(email, password, );
  }

  //登入
  Future<void> login(String email, String password) async {
    final DataState<LoginResponse> response = await _apiRepository.login(
        request: LoginRequest(email: email, password: password));

    if (response is DataSuccess) {
      _auth = response.data?.data;
      print(_auth!.expireDate);
      /*
      print(_auth!.userId);
      print(_auth!.token);
      print(_auth!.expireDate);
      print(_auth!.refreshToken);
      print("isAuth: ${isAuth}");
       */
      //登入成功
      if (_auth != null) {
        //記錄使用者資料
        await _userRepository.saveUserData(jsonEncode(_auth));
        //final prefs = await SharedPreferences.getInstance();
        //prefs.setString('userData',_auth!.toJson().toString() );

        //todo:check for valid  no null
        _autoLogout(); // 註冊時間超過要Logout
        notifyListeners();
      } else {
        logout();
      }
    } else if (response is DataFailed) {
      logout();
    }
  }

  //使用者自動登入
  Future<bool> tryAutoLogin() async {
    //查詢是否已經有使用者資料

    String? userStr=await _userRepository.getUserData();

    ;
    //final prefs = await SharedPreferences.getInstance();
    //if (!prefs.containsKey('userData')) {
    //  return false;
    //}

    if (userStr==null || userStr.isEmpty) {
      return false;
    }

    final extractedUserData = json.decode(userStr!) as Map<
        String,
        Object>;

    final expiryDate = Auth
        .fromJson(extractedUserData)
        .expireDate;

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _auth = Auth.fromJson(extractedUserData);
    notifyListeners();
    _autoLogout();
    return true;
  }


  //手動登出
  void logout() async {
    _auth = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    _userRepository.clear();
    //final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    //prefs.clear();
  }

  //超過Expire時間自動登出
  void _autoLogout() {
    print("autologout");
    if (_auth?.expireDate != null) {
      if (_authTimer != null) _authTimer!.cancel();
      //計算何時會過期
      //print("expire:${_auth?.expireDate}");
      //print("now:${DateTime.now()}");
      final timeToExpire = _auth?.expireDate
          ?.difference(DateTime.now())
          .inSeconds;
      //print("diff:${timeToExpire}");


      //時間到就跳出
      _authTimer = Timer(Duration(seconds: timeToExpire!), logout);
      //_authTimer = Timer(const Duration(seconds: 3), logout);
    }
  }
}
