import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tasks/Models/Response/response.dart';
import 'package:firebase_tasks/Services/Firebase/Auth/firebase_auth.dart';

class DatabaseServices {
  CollectionReference personalDetailsCollection =
      FirebaseFirestore.instance.collection('personalDetails');

  CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('Employee');

// CREATE employee record
  Future<Response> addEmployee({
    required String name,
    required String position,
    required String contactno,
  }) async {
    Response response = Response();

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    var ref = employeeCollection.doc();

    var result = await ref.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

// Read employee records
  Stream<QuerySnapshot> readEmployee() {
    return employeeCollection.snapshots();
  }

// Update employee record
  Future<Response> updateEmployee({
    required String name,
    required String position,
    required String contactno,
    required String docId,
  }) async {
    Response response = Response();

    var ref = employeeCollection.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    await ref.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

// Delete Employee record
  Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();

    print('hello');

    var ref = employeeCollection.doc(docId);

    await ref.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  Future<void> setPersonalDetails() async {
    final data = {
      'firstName': 'Vibhor',
      'lastName': 'Vats',
      'dob': '17 Nov',
      'phoneNumber': '9389938900',
      'gender': 'Male',
    };

    var user = AuthService().currentUser!;
    var ref = personalDetailsCollection.doc(user.uid);

    return await ref.set(data);
  }
}
