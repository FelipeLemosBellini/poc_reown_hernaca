import 'package:flutter/material.dart';
import 'package:poc_wallet_connect/deep_link_handler.dart';
import 'package:poc_wallet_connect/home.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_wallet_connect/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeepLinkHandler.initListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: MyRouter.router,
    );
  }
}
