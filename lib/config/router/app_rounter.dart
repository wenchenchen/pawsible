import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/screens/auth_screen.dart';
import '../../presentation/screens/error_screen.dart';
import '../../presentation/screens/home_screen.dart';


//路徑設定
GoRouter router(AuthProvider auth) {
  //print('isAuth=${auth.isAuth}');
  return
    GoRouter(
      refreshListenable: auth,
      debugLogDiagnostics: false,
      initialLocation: '/home',
      routes: [
      GoRoute(
        name: 'auth_screen',
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
          name: 'home_screen',
          path: '/home', //path with parameter: '.../town:ccode/:cname',
          builder: (context, state) => const HomeScreen()),
    ],
    redirect: (context, state){
    //  print('provider isAuth = ${Provider.of<AuthProvider>(context).isAuth} ');
    //  print('redirect isAuth = ${auth.isAuth}');
    if (!auth.isAuth){
      return '/auth';
    }else {
      //print('go home');
      return null;
    }

  },
  errorBuilder:(context, state) => ErrorScreen(error:state.error),

    );
}
