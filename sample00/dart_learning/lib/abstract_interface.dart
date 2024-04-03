/* interface */
interface class InterfaceVehicle {
  int? speed;

  void moveForward(int meters) {
    print('move forward $meters meters');
  }
}

// class MockVehicle implements InterfaceVehicle {
//   @override
//   int? speed;

//   @override
//   moveForward(int meters) {
//     print('mock move forward $meters meters');
//   }
// }

/* abstract */
abstract class AbstractVehicle {
  int? speed;

  void moveForward(int meters);
  void moveLeft(int meters) {
    print('move left $meters meters');
  }
}

class MockVehicle implements AbstractVehicle {
  @override
  int? speed;

  @override
  moveForward(int meters) {
    print('mock move forward $meters meters');
  }

  //moveLeft(int meters) {}
}
