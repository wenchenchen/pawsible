import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider=Provider.of<AuthProvider>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('userid : ${ (authProvider.userId??'')}'),
          Text('token : ${ (authProvider.token??'')}'),
          Text('expire : ${ (authProvider.tokenExpireDate?.toLocal().toString())}'),
          Text('refresh token : ${ (authProvider.refreshToken??'')}'),

        ],
      ),

    );
  }
}
