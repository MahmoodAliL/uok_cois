import 'package:flutter/material.dart';

class LoadingItemWidget extends StatelessWidget {
  const LoadingItemWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
