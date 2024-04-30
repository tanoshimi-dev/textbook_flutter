// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/providers/favorite_provider.dart';
import '/providers/tab_menu_state_provider.dart';
import '/models/menu.dart';
import '/models/menus.dart';

class MenuListScreen extends StatelessWidget {
  const MenuListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tabMenuStateProvider = context.watch<TabManuStateProvider>();
    final int _currentIndex = tabMenuStateProvider.tabMenuIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu', style: Theme.of(context).textTheme.displayLarge),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Favorites',
          ),
        ],
        // Set the current index
        currentIndex: _currentIndex,
        onTap: (int index) {
          tabMenuStateProvider.setTabMenuIndex(index);
          print('Add your code here');

          if (index == 0) {
            context.go('/menus');
          } else {
            context.go('/menus/favorites');
          }
        },
      ),
    );
  }
}

class _FavIcon extends StatelessWidget {
  final Menu menu;

  const _FavIcon({required this.menu});

  @override
  Widget build(BuildContext context) {
    var isFavorite = context.select<FavoriteProvider, bool>(
      (favoriteProvider) => favoriteProvider.favoritesMenu.contains(menu),
    );

    return isFavorite
        ? Icon(
            Icons.check,
            color: Colors.grey, // Change the color of the icon
            size: 24.0, // Change the size of the icon
            semanticLabel: 'ADDED',
          )
        : Text('');
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
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: LimitedBox(
        maxHeight: 24,
        child: InkWell(
          onTap: () => context.go('/menus/detail/${menu.menuId}'),
          child: Row(
            children: [
              Text(menu.menuId.toString()),
              const SizedBox(width: 24),
              Expanded(
                child: Text(menu.name, style: textTheme),
              ),
              const SizedBox(width: 6),
              _FavIcon(menu: menu),
            ],
          ),
        ),
      ),
    );
  }
}
