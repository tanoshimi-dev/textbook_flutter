import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_data.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyData, int>(
        builder: (context, count) => Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium,
            ));
    // Text(count.toString(), style: Theme.of(context).textTheme.headline4);
  }
}
