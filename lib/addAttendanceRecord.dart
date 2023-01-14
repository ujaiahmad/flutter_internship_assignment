import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment/userList.dart';
import 'package:intl/intl.dart';

//6. Users able to add a new attendance record into the list
class AddAttendanceRecord extends StatefulWidget {
  final String format;
  const AddAttendanceRecord({super.key, required this.format});

  @override
  State<AddAttendanceRecord> createState() => _AddAttendanceRecordState();
}

class _AddAttendanceRecordState extends State<AddAttendanceRecord> {
  final userController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Attendance Record'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: userController,
                decoration: const InputDecoration(
                    labelText: 'User', border: OutlineInputBorder()),
                validator: (value) {
                  if (userController.text == '') {
                    return 'Enter User...';
                  }
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Phone Number', border: OutlineInputBorder()),
                validator: (value) {
                  if (phoneController.text == '') {
                    return 'Enter Phone Number...';
                  }
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        if (widget.format == 'dd-mm-yyyy') {
                          //since you did not mention to preserve the contact list,
                          //the contact will be lost after refreshing
                          contactList.insert(0, {
                            'user': userController.text,
                            'phone': phoneController.text,
                            'check-in': DateFormat('dd-MM-yyyy hh:mm a')
                                .format(DateTime.now())
                                .toString()
                          });
                        } else {
                          contactList.insert(0, {
                            'user': userController.text,
                            'phone': phoneController.text,
                            'check-in': DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(DateTime.now())
                                .toString()
                          });
                        }
                      });
                      //7. When user successfully add new record to the
                      //list, an indicator should be display that
                      //user had successfully completed the action
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User Added!!')));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
