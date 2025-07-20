import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final jobController = TextEditingController();
  final addressController = TextEditingController();
  String selectedGender = 'Male';

  Future<void> saveAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('job', jobController.text);
    await prefs.setString('address', addressController.text);
    await prefs.setString('gender', selectedGender);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(controller: firstNameController, decoration: InputDecoration(labelText: 'First Name')),
            TextFormField(controller: lastNameController, decoration: InputDecoration(labelText: 'Last Name')),
            TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextFormField(controller: jobController, decoration: InputDecoration(labelText: 'Job Title')),
            TextFormField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),
            DropdownButtonFormField(
              value: selectedGender,
              items: ['Male', 'Female']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedGender = val!;
                });
              },
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveAccount, child: Text('Save Account')),
          ]),
        ),
      ),
    );
  }
}