import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_data.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyData data = context.watch<MyData>();
    //print('s2 {$data.count}');
    return Text(
      '${data.count.toString()}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
    // Text(count.toString(), style: Theme.of(context).textTheme.headline4);
  }
}
