import 'package:firebase_tasks/Services/Firebase/Database/database_services.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final _employeeName = TextEditingController();
  final _employeePosition = TextEditingController();
  final _employeeContact = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _employeeName.dispose();
    _employeePosition.dispose();
    _employeeContact.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final viewListbutton = TextButton(
    //     onPressed: () {
    //       Navigator.pushAndRemoveUntil<dynamic>(
    //         context,
    //         MaterialPageRoute<dynamic>(
    //           builder: (BuildContext context) => ListPage(),
    //         ),
    //         (route) => false, //To disable back feature set to false
    //       );
    //     },
    //     child: const Text('View List of Employee'));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Employee Info Page'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Fields(fieldInfo: _employeeName, hintText: "Name"),
                    const SizedBox(height: 25.0),
                    Fields(fieldInfo: _employeePosition, hintText: "Position"),
                    const SizedBox(height: 35.0),
                    Fields(
                        fieldInfo: _employeeContact,
                        hintText: "Contact Number"),
                    // viewListbutton,
                    const SizedBox(height: 45.0),
                    SaveButton(
                      formKey: _formKey,
                      employeeName: _employeeName,
                      employeePosition: _employeePosition,
                      employeeContact: _employeeContact,
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({super.key, required this.fieldInfo, required this.hintText});

  final TextEditingController fieldInfo;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: fieldInfo,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    ;
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton(
      {super.key,
      required this.formKey,
      required this.employeeName,
      required this.employeePosition,
      required this.employeeContact});

  final GlobalKey<FormState> formKey;
  final TextEditingController employeeName;
  final TextEditingController employeePosition;
  final TextEditingController employeeContact;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            var response = await DatabaseServices().addEmployee(
                name: employeeName.text,
                position: employeePosition.text,
                contactno: employeeContact.text);
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
