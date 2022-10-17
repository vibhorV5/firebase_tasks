import 'package:firebase_tasks/Models/Employee/employee.dart';
import 'package:firebase_tasks/Services/Firebase/Database/database_services.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Employee? employee;

  const EditPage({super.key, this.employee});

  @override
  State<StatefulWidget> createState() {
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _employeeName = TextEditingController();
  final _employeePosition = TextEditingController();
  final _employeeContact = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _docid.value = TextEditingValue(text: widget.employee!.uid.toString());
    _employeeName.value =
        TextEditingValue(text: widget.employee!.employeename.toString());
    _employeePosition.value =
        TextEditingValue(text: widget.employee!.position.toString());
    _employeeContact.value =
        TextEditingValue(text: widget.employee!.contactno.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _employeeContact.dispose();
    _employeeName.dispose();
    _employeePosition.dispose();
    _docid.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('FreeCode Spot'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
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
                  DocIdField(
                    docId: _docid,
                  ),
                  const SizedBox(height: 25.0),
                  Fields(fieldInfo: _employeeName, hintText: "Name"),
                  const SizedBox(height: 25.0),
                  Fields(fieldInfo: _employeePosition, hintText: "Postion"),
                  const SizedBox(height: 35.0),
                  Fields(
                      fieldInfo: _employeeContact, hintText: "Contact Number"),
                  const SizedBox(height: 45.0),
                  SaveButton(
                    formKey: _formKey,
                    employeeName: _employeeName,
                    employeePosition: _employeePosition,
                    employeeContact: _employeeContact,
                    docId: _docid,
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
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

class DocIdField extends StatelessWidget {
  const DocIdField({super.key, required this.docId});

  final TextEditingController docId;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: docId,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.formKey,
    required this.employeeName,
    required this.employeePosition,
    required this.employeeContact,
    required this.docId,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController employeeName;
  final TextEditingController employeePosition;
  final TextEditingController employeeContact;
  final TextEditingController docId;

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
            var response = await DatabaseServices().updateEmployee(
                name: employeeName.text,
                position: employeePosition.text,
                contactno: employeeContact.text,
                docId: docId.text);
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
