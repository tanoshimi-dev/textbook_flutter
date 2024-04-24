// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:step1/providers/favorite_provider.dart';
import '../models/menu.dart';
import '../models/menus.dart';

class MenuListScreen extends StatelessWidget {
  const MenuListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu', style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.thumb_up),
            onPressed: () => context.go('/menus/favorites'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          //_MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // return ListTile(
              //   leading: Icon(Icons.person),
              //   title: Text('Item ${index + 1}'),
              // );
              return _MyListItem(index);
            },
            //    (context, index) => _MyListItem(index)),
            childCount: Menus.list.length,
          )),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Menu menu;

  const _AddButton({required this.menu});

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
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
              print(menu.name);
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

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('MENU', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => context.go('/menus/favorites'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    // var menu = context.select<Menus, Menu>(
    //   (menu) => Menus.list[index],
    // );
    //final menu = context.watch<FavoriteProvider>().favoritesMenu;
    final menu = Menus.list[index];
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LimitedBox(
        maxHeight: 24,
        child: InkWell(
          onTap: () => context.go('/menus/detail/${menu.menuId}'),
          child: Row(
            children: [
              // AspectRatio(
              //   aspectRatio: 1,
              //   child: Text(menu.menuId.toString()),
              // ),
              Text(menu.menuId.toString()),
              const SizedBox(width: 24),
              Expanded(
                child: Text(menu.name, style: textTheme),
              ),
              const SizedBox(width: 12),
              //_AddButton(menu: menu),
            ],
          ),
        ),
      ),
    );
  }
}
