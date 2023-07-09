import 'package:get/get.dart';

import 'Mymedals.dart';
import 'Personinfoc.dart';
import 'auth_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
 Get.put(PersonalinfoController(), permanent: true);
 // Get.put(MedalsController(), permanent: true);
 
  }
}
