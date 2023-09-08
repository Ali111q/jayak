import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jayak/controller/auth_controller.dart';
import 'package:jayak/model/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthController>(context).user!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "معلومات المستخدم",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                 
                    Container(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "اسم المستخدم",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: user.name,
                        border: OutlineInputBorder()),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'رقم الهاتف',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: user.mobile,
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
              Center(child: TextButton(onPressed: (){Provider.of<AuthController>(context, listen: false).logout();
              Navigator.of(context).pushNamedAndRemoveUntil('/launch', (route) => false);
              }, child: Text('تسجيل خروج', style: TextStyle(fontSize: 20),)))
            ],
          ),
        ),
      ),
    );
  }
}
