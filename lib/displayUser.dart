import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';

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
  // DateTime timeNow = DateTime.now();

  // calculateHoursAgo(time, format) {
  //   if (format == 'dd-mm-yyyy') {
  //     var inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
  //     var inputDate = inputFormat.parse(time);
  //     var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  //     var outputDate = outputFormat.format(inputDate);
  //     return timeNow.difference(DateTime.parse(outputDate)).inHours.toString();
  //   } else {
  //     return timeNow.difference(DateTime.parse(time)).inHours.toString();
  //   }
  // }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'User Attendance',
      text:
          'Name: ${widget.user}\nPhone: ${widget.phone}\nCheck-in:${widget.dateTime}, ${widget.hoursAgo} hours ago',
    );
  }

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
                  //3. The time format should be display in the
                  //format of “time ago” eg. 1 hour ago
                  Text(
                    '${widget.hoursAgo} hours ago',
                  ),
                  // Text('Checked in: ${widget.hoursAgo} hours ago'),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Flexible(
              flex: 2,
              child: IconButton(
                  onPressed: () {
                    share();
                  },
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
