import 'package:flutter/foundation.dart';

class MyData extends ChangeNotifier {
  int count = 0;

  void increment() {
    this.count = count + 1;
    print('count: ${count.toString()}');
    notifyListeners();
  }
}
