import 'package:flutter/material.dart';

class SugorokuPage extends StatelessWidget {
  const SugorokuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("daily sugoroku app!"),
      ),
      body: Center(
        child: Column(children: const [
          Text("sugoroku しようぜ"),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/edit');
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
