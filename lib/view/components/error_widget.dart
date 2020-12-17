import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final Function onRetry;
  final String errorMessage;

  const ErrorWidget(
      {Key key,
      this.onRetry,
      this.errorMessage = 'قد لا يتوفر اتصال بالانترنيت'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'حدث خطأ ما',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 0,
              highlightElevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 24),
              color: Colors.green.shade700,
              textColor: Colors.white,
              onPressed: onRetry,
              child: Text('اعادة المحاولة'),
            )
          ],
        ),
      ),
    );
  }
}
