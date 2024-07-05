import 'package:flutter/material.dart';
import 'package:flutter_task/domain/usecases/fetch_users.dart';
import '../controllers/user_list_controller.dart';
import '../widgets/user_card_widget.dart';
import '../../domain/entities/user_entity.dart';
import 'package:get/get.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserListController controller =
        Get.put(UserListController(fetchUsers: FetchUsers()));

    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final UserEntity user = controller.users[index];
            return UserCardWidget(user: user);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.refreshUsers();
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
