import 'package:flutter/material.dart';

class DisplayUser extends StatefulWidget {
  final String user;
  final String phone;
  final String dateTime;
  final String hoursAgo;
  const DisplayUser({
    Key? key,
    required this.user,
    required this.phone,
    required this.dateTime,
    required this.hoursAgo,
  }) : super(key: key);

  @override
  State<DisplayUser> createState() => _DisplayUserState();
}

class _DisplayUserState extends State<DisplayUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    widget.user,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text('Phone: ${widget.phone}'),
                  const SizedBox(height: 5),
                  Text('Check in: ${widget.dateTime}, '),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.hoursAgo} hours ago',
                    style: const TextStyle(fontSize: 12),
                  ),
                  // Text('Checked in: ${widget.hoursAgo} hours ago'),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Flexible(
              flex: 2,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  )),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}
