import 'package:flutter_bloc/flutter_bloc.dart';

class MyDataCounterCubit extends Cubit<int> {
  MyDataCounterCubit() : super(0);

  void increment() {
    emit(state + 1);
    print('count: ${state.toString()}');
  }
}
