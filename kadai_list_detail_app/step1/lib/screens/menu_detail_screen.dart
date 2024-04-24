// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:step1/providers/favorite_provider.dart';
import '../models/menu.dart';
import '../models/menus.dart';

class MenuDetailScreen extends StatelessWidget {
  const MenuDetailScreen({super.key, required this.menuId});
  final int menuId;

  @override
  Widget build(BuildContext context) {
    Menu? menu = Menus.list.firstWhere((menu) => menu.menuId == menuId,
        orElse: () => const Menu(
            menuId: 1, name: 'Unknown Menu', description: '', price: 0));

    return Scaffold(
      appBar: AppBar(
        title: Text('MENU $menuId DETAIL',
            style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.thumb_up),
            onPressed: () => context.go('/menus/favorites'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(menu.name, style: Theme.of(context).textTheme.titleLarge),
            Text(menu.description,
                style: Theme.of(context).textTheme.titleSmall),
            Text('\$${menu.price}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            _FavButton(menu: menu),
          ],
        ),
      ),
    );
  }
}

class _FavButton extends StatelessWidget {
  final Menu menu;

  const _FavButton({required this.menu});

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    //var favoriteProvider = context.watch<FavoriteProvider>();
    // var favoriteProvider =
    //     Provider.of<FavoriteProvider>(context, listen: false);
    // var isFavorite = favoriteProvider.favoritesMenu.contains(menu);

    var isFavorite = context.select<FavoriteProvider, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (favoriteProvider) => favoriteProvider.favoritesMenu.contains(menu),
    );

    return TextButton(
      onPressed: isFavorite
          ? null
          : () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var favoriteProvider = context.read<FavoriteProvider>();
              favoriteProvider.add(menu);
              print('Favorite add $menu.name');
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isFavorite
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}
