import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment/addAttendanceRecord.dart';
import 'package:flutter_internship_assignment/search.dart';
import 'package:flutter_internship_assignment/userList.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'displayUser.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool isLoad;
  late List<bool> _selectedFormat;
  String format1 = 'yyyy-mm-dd';
  // String format1 = 'dd-mm-yyyy';
  DateTime timeNow = DateTime.now();

  //5. The time format changes should be keep even if users terminate/kill the app
  // I used sharedpreferences library
  Future<void> _loadformat() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // isLoad = true;
      format1 = (prefs.getString('format') ?? 'yyyy-mm-dd');
      changeDate(format1);
      print('this is load format ${format1}');
      // isLoad = false;
    });
  }

  Future<void> _setformat(format) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('format', format);
    });
  }

  //1. Display the records in the form of
  //list view and sorted based on the time.
  //2. The list of records should be sorted
  //from the most recent to the oldest.
  sortContact() {
    print('sort contract');
    contactList.sort(
      (a, b) {
        DateTime dateA = DateTime.parse(a['check-in']);
        DateTime dateB = DateTime.parse(b['check-in']);
        print('sort successfull');
        return dateB.compareTo(dateA);
      },
    );
  }

  changeToggle() {
    if (format1 == 'yyyy-mm-dd') {
      return true;
    } else {
      return false;
    }
  }

  calculateHoursAgo(time, format1) {
    print('calcualate hours ago ${format1}');
    if (format1 == 'dd-mm-yyyy') {
      var inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var inputDate = inputFormat.parse(time);
      var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      var outputDate = outputFormat.format(inputDate);
      print('calculate hours ago succesfull');
      return timeNow.difference(DateTime.parse(outputDate)).inHours.toString();
    } else {
      print('calculate hours ago2 succesfull');
      return timeNow.difference(DateTime.parse(time)).inHours.toString();
    }
  }

  //4. The time format also be able to display
  //in other format “dd MMM yyyy, h:mm a” with the
  //change of toggle button
  //I used the intl library
  changeDate(format) async {
    // setState(() {
    //   isLoad = true;
    // });

    // _loadformat();

    if (format == 'dd-mm-yyyy') {
      for (int i = 0; i < contactList.length; i++) {
        var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
        var inputDate = inputFormat.parse(contactList[i]['check-in']);
        var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
        var outputDate = outputFormat.format(inputDate);
        contactList[i]['check-in'] = outputDate;
        print(contactList[i]['check-in']);
      }
    } else {
      for (int i = 0; i < contactList.length; i++) {
        if (DateTime.tryParse(contactList[i]['check-in']) == null) {
          var inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
          var inputDate = inputFormat.parse(contactList[i]['check-in']);
          var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
          var outputDate = outputFormat.format(inputDate);
          contactList[i]['check-in'] = outputDate;
          print(contactList[i]['check-in']);
        } else {
          contactList[i]['check-in'] = DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(DateTime.parse(contactList[i]['check-in']))
              .toString();
          print(contactList[i]['check-in']);
        }
      }
    }

    setState(() {
      isLoad = false;
    });
  }

  @override
  void initState() {
    // isLoad = true;
    // TODO: implement initState
    // Future.delayed(Duration(seconds: 1), _loadformat);
    _loadformat();
    sortContact(); //1. Display the records in the form of list view and sorted based on the time.
    changeDate(format1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attendance Records'),
        ),
        body: isLoad
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Date Format '),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ToggleButtons(
                          //4. The time format also be able to display in other format
                          // “dd MMM yyyy, h:mm a” with the
                          //change of toggle button
                          isSelected: changeToggle()
                              ? _selectedFormat = <bool>[true, false]
                              : _selectedFormat = <bool>[false, true],
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < _selectedFormat.length; i++) {
                                _selectedFormat[i] = i == index;
                              }
                              if (format1 == 'dd-mm-yyyy') {
                                if (_selectedFormat[0] == true) {
                                  format1 = 'yyyy-mm-dd';
                                  changeDate(format1);
                                  _setformat(format1);
                                }
                              } else {
                                if (_selectedFormat[0] == false) {
                                  format1 = 'dd-mm-yyyy';
                                  changeDate(format1);
                                  _setformat(format1);
                                }
                              }
                            });
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
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
        //6. Users able to add a new attendance record into the list
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
