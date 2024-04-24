import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyData extends Notifier<int> {
  final count = 0;
  @override
  int build() {
    return count;
  }

  void increment() {
    this.state = state + 1;
    print('count: ${state.toString()}');
  }
}
