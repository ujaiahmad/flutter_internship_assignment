import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment/addNewUser.dart';
import 'package:flutter_internship_assignment/search.dart';
import 'package:flutter_internship_assignment/userList.dart';
import 'package:intl/intl.dart';

import 'displayUser.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool isLoad;
  final List<bool> _selectedFormat = <bool>[true, false];
  String format1 = 'yyyy-mm-dd';
  DateTime timeNow = DateTime.now();

  sortContact() {
    contactList.sort(
      (a, b) {
        DateTime dateA = DateTime.parse(a['check-in']);
        DateTime dateB = DateTime.parse(b['check-in']);
        return dateB.compareTo(dateA);
      },
    );
    //print(contactList.toString());
  }

  calculateHoursAgo(time, format1) {
    if (format1 == 'dd-mm-yyyy') {
      var inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var inputDate = inputFormat.parse(time);
      var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      var outputDate = outputFormat.format(inputDate);
      return timeNow.difference(DateTime.parse(outputDate)).inHours.toString();
    } else {
      return timeNow.difference(DateTime.parse(time)).inHours.toString();
    }
  }

  changeDate(format) {
    setState(() {
      isLoad = true;
    });

    if (format == 'dd-mm-yyyy') {
      for (int i = 0; i < contactList.length; i++) {
        var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
        var inputDate = inputFormat.parse(contactList[i]['check-in']);
        var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
        var outputDate = outputFormat.format(inputDate);
        contactList[i]['check-in'] = outputDate;
      }
    } else {
      for (int i = 0; i < contactList.length; i++) {
        var inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
        var inputDate = inputFormat.parse(contactList[i]['check-in']);
        var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
        var outputDate = outputFormat.format(inputDate);
        contactList[i]['check-in'] = outputDate;
      }
    }

    setState(() {
      isLoad = false;
    });
  }

  @override
  void initState() {
    isLoad = true;
    // TODO: implement initState
    // changeDate('yyyy-MM-dd');
    sortContact(); // sort the contact before displaying
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attendance Records'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Date Format '),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleButtons(
                    isSelected: _selectedFormat,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _selectedFormat.length; i++) {
                          _selectedFormat[i] = i == index;
                        }
                        if (format1 == 'dd-mm-yyyy') {
                          //if the same then ignore
                          if (_selectedFormat[0] == true) {
                            changeDate('yyyy-mm-dd');
                            format1 = 'yyyy-mm-dd';
                          }
                        } else {
                          if (_selectedFormat[0] == false) {
                            changeDate('dd-mm-yyyy');
                            format1 = 'dd-mm-yyyy';
                          }
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('yyyy-mm-dd'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('dd-mm-yyyy'),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(format1));
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            const Text('Attendance List'),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: contactList.length + 1,
                itemBuilder: (context, index) {
                  if (index < contactList.length) {
                    //display all user inside the list
                    return DisplayUser(
                      user: contactList[index]['user'].toString(),
                      phone: contactList[index]['phone'].toString(),
                      dateTime: contactList[index]['check-in'].toString(),
                      hoursAgo: calculateHoursAgo(
                          contactList[index]['check-in'], format1),
                    );
                  } else {
                    //tells the user its the end of the list
                    return const Center(
                        child: Text(
                      'You have reached the end of the list',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (context) => AddAttendanceRecord(format: format1),
                ))
                .then((value) => setState(() {
                      changeDate(format1);
                    }));
          },
          icon: const Icon(Icons.add),
          label: const Text('Attendance Record'),
        ));
  }
}
