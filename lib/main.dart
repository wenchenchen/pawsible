
import 'package:pawsible/domain/contracts/user_repository.dart';
import 'package:pawsible/presentation/providers/recipe_designer_provider.dart';
import 'package:pawsible/utils/locator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'config/router/app_rounter.dart';
import 'config/themes/app_theme.dart';
import 'domain/contracts/api_repository.dart';
import 'presentation/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
  runApp(const MyApp());
}

//路徑設定
//設定螢幕路徑


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider(locator<ApiRepository>(),locator<UserRepository>())),
        ChangeNotifierProvider.value(value: RecipeDesignerProvider()),
      ],
      child: Consumer<AuthProvider>(builder: (ctx, auth, _) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title:'JWT API認證測試系統',
        routerConfig: router(auth),
        //theme: AppTheme.light

      )
      ),
    );
  }
}
