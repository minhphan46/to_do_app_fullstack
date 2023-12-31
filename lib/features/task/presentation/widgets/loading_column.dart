import 'package:flutter/cupertino.dart';

class LoadingColumn extends StatelessWidget {
  final String message;
  const LoadingColumn({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          const SizedBox(height: 10),
          Text(message),
        ],
      ),
    );
  }
}
