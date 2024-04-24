// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:step1/screens/favorites_screen.dart';
import '/common/theme.dart';
import '/models/cart.dart';
import '/models/catalog.dart';
import '/models/menu.dart';
import '/models/menus.dart';
import '/providers/favorite_provider.dart';
import '/screens/cart.dart';
import '/screens/catalog.dart';
import 'screens/menu_detail_screen.dart';
import 'screens/menu_list_screen.dart';
import '/screens/login.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
      GoRoute(
        path: '/menus',
        builder: (context, state) => const MenuListScreen(),
        //builder: (context, state) => MenuListScreen(),
        routes: [
          GoRoute(
            path: 'detail/:id',
            builder: (context, state) => MenuDetailScreen(
                menuId: int.parse(state.pathParameters['id']!)),
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        // ChangeNotifierProxyProvider<Menus, FavoriteProvider>(
        //   create: (context) => FavoriteProvider(),
        //   update: (context, menu, favoriteProvider) {
        //     if (favoriteProvider == null)
        //       throw ArgumentError.notNull('favoriteProvider');
        //     favoriteProvider.add(menu as Menu);
        //     return favoriteProvider;
        //   },
        // ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
