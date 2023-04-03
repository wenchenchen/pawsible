import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/exceptions/http_exception.dart';
import '../providers/auth_provider.dart';

enum AuthMode { signUp, logIn }

class AuthCardWidget extends StatefulWidget {
  const AuthCardWidget({Key? key}) : super(key: key);

  @override
  State<AuthCardWidget> createState() => _AuthCardWidgetState();
}

class _AuthCardWidgetState extends State<AuthCardWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.logIn;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController(text:"!Password1");

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
          /*height: _authMode == AuthMode.signUp
              ? deviceSize.height * 0.4
              : deviceSize.height * 0.3,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.signUp
                  ? deviceSize.height * 0.4
                  : deviceSize.height * 0.3),

           */
          width: deviceSize.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  initialValue: "userx@example.com",
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return '無效的Email格式';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) _authData['email'] = value;
                  },
                ),
                TextFormField(

                  decoration: const InputDecoration(labelText: '密碼'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return '密碼長度需大於8碼';
                    }
                  },
                  onSaved: (value) {
                    if (value != null) _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.signUp)
                  TextFormField(
                    enabled: _authMode == AuthMode.signUp,
                    decoration: const InputDecoration(labelText: '確認密碼'),
                    obscureText: true,
                    validator: _authMode == AuthMode.signUp
                        ? (value) {
                            if (value != _passwordController.text) {
                              return '確認密碼不符合!';
                            }
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {

                            _submit();
                          },
                          child:
                              Text(_authMode == AuthMode.logIn ? '登入' : '註冊')),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _switchAuthMode();
                          },
                          child: Text(_authMode == AuthMode.logIn ? '註冊' : '登入'))
                    ],
                  )
              ]),
            ),
          )),
    );
  }

  //轉換註冊與登入模式
  void _switchAuthMode() {
    if (_authMode == AuthMode.logIn) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.logIn;
      });
    }
  }

  //送出
  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.logIn) {
        // 使用者登入
        await Provider.of<AuthProvider>(context, listen: false).login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // 註冊使用者
        await Provider.of<AuthProvider>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on HttpException catch (error) {
      //todo 錯誤處理
      var errorMessage = '驗證錯誤';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      //_showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          '目前無法進行帳密驗證，請稍後再試！';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  //錯誤訊息提示
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('發生錯誤!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('確定'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
