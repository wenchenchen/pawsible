import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../widgets/login_card_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    //取得裝置大小
    final deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        height: deviceSize.height,
        width: deviceSize.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(child: AuthCardWidget()),

          ],
        ),
      ),
    );
  }
}
