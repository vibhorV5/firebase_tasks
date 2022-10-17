import 'package:firebase_tasks/Models/Employee/employee.dart';
import 'package:firebase_tasks/Screens/EditPage/edit_page.dart';
import 'package:firebase_tasks/Services/Firebase/Database/database_services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference =
      DatabaseServices().readEmployee();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("List of Employee"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                alignment: Alignment.center,
                height: 800,
                child: const CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                      child: Column(children: [
                    ListTile(
                      title: Text(e["employee_name"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Position: " + e['position'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Contact Number: " + e['contact_no'],
                                style: const TextStyle(fontSize: 12)),
                          ],
                        )),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Edit'),
                          onPressed: () {
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => EditPage(
                                  employee: Employee(
                                      uid: e.id,
                                      employeename: e["employee_name"],
                                      position: e["position"],
                                      contactno: e["contact_no"]),
                                ),
                              ),
                            );
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Delete'),
                          onPressed: () async {
                            var response = await DatabaseServices()
                                .deleteEmployee(docId: e.id);
                            if (response.code != 200) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text(response.message.toString()),
                                    );
                                  });
                            }
                          },
                        ),
                      ],
                    ),
                  ]));
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
