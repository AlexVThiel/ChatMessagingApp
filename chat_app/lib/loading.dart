import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  static const routeName = '/Loading';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
