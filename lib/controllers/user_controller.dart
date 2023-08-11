import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

import '../model/user.dart';

class UserController extends GetxController {
  List<User> users = <User>[].obs;

  void addUser({required user}) {
    users.add(user);
    print('user added successfully');
  }
}
