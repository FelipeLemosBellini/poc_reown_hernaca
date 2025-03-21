import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_wallet_connect/home.dart';

abstract class MyRouter {
  static const String login = "/";

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: login,
        builder: (BuildContext context, GoRouterState state) {
          return const Home();
        },
        routes: const <RouteBase>[],
      ),
    ],
  );
}
