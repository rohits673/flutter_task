import 'package:get/get.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/fetch_users.dart';

class UserListController extends GetxController {
  final FetchUsers fetchUsers;

  UserListController({required this.fetchUsers});

  var users = <UserEntity>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    isLoading.value = true;
    final result = await fetchUsers();
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (userList) {
        users.value = userList;
      },
    );
    isLoading.value = false;
  }

  Future<void> refreshUsers() async {
    await _fetchUsers();
  }
}
