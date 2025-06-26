import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 10), Text(message)]),
        ),
      ),
    );
  }
}
