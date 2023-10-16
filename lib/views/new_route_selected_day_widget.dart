import 'package:flutter/material.dart';

class NewRouteSelectedDay extends StatelessWidget {
  const NewRouteSelectedDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: const Center(
        child: Text("Selected Day"),
      ),
    );
  }
}
