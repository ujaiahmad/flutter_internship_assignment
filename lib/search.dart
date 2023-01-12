import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment/displayUser.dart';
import 'package:flutter_internship_assignment/userList.dart';
import 'package:intl/intl.dart';

class CustomSearchDelegate extends SearchDelegate {
  DateTime timeNow = DateTime.now();
  final String format1;
  CustomSearchDelegate(this.format1);

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

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> matchQuery = [];
    for (int i = 0; i < contactList.length; i++) {
      if (contactList[i]['user']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(contactList[i]);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return DisplayUser(
            user: matchQuery[index]['user'],
            phone: matchQuery[index]['phone'],
            dateTime: matchQuery[index]['check-in'],
            hoursAgo:
                calculateHoursAgo(matchQuery[index]['check-in'], format1));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> matchQuery = [];
    for (int i = 0; i < contactList.length; i++) {
      if (contactList[i]['user']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(contactList[i]);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return DisplayUser(
            user: matchQuery[index]['user'],
            phone: matchQuery[index]['phone'],
            dateTime: matchQuery[index]['check-in'],
            hoursAgo:
                calculateHoursAgo(matchQuery[index]['check-in'], format1));
      },
    );
  }
}
