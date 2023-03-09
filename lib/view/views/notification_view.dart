// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text("Notification"))),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Card(
                child: ListTile(
                    // leading: const Icon(Icons.list),
                    trailing: const Icon(
                      Icons.more_vert,
                    ),
                    title: Text("List item $index")),
              ),
            );
          }),
    );
  }
}
