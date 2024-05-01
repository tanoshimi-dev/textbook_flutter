import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyData extends StateNotifier<int> {
  MyData() : super(0);

  void increment() {
    this.state = state + 1;
    print('count: ${this.state.toString()}');
  }
}
