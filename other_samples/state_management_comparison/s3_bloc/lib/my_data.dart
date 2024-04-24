import 'package:flutter_bloc/flutter_bloc.dart';

class MyData extends Cubit<int> {
  MyData() : super(0);

  void increment() {
    emit(state + 1);
    print('count: ${state.toString()}');
  }
}
