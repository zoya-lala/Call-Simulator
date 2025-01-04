import 'package:flutter/material.dart';

class IncomingCallDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const IncomingCallDialog({
    Key? key,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Incoming Call'),
      content: const Text('You have an incoming call.'),
      actions: [
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
                shape: MaterialStatePropertyAll(
                  CircleBorder(),
                ),
              ),
              onPressed: onDecline,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.call_end_rounded,
                  color: Colors.white,
                ),
              ),
              // child: const Text('Decline'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
                shape: MaterialStatePropertyAll(
                  CircleBorder(),
                ),
              ),
              onPressed: onAccept,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
              // child: const Text('Accept'),
            ),
          ],
        )
      ],
    );
  }
}
