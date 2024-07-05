import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';

class UserCardWidget extends StatelessWidget {
  final UserEntity user;

  const UserCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Text(user.phone),
          ],
        ),
      ),
    );
  }
}
