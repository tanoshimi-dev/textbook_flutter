import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';

class MyWidget extends ConsumerWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値が更新されたら自動的に反映される
    final count = ref.watch(countProvider);
    return Text(
      '$count',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
