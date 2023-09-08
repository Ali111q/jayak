import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jayak/controller/auth_controller.dart';
import 'package:jayak/helper/image_picker.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? image;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "تسجيل",
            style: TextStyle(color: Colors.black),
          ),
          leading: Container(),
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
                  Container(height: MediaQuery.of(context).size.height*0.3,),
                    Container(
                      height: 10,
                    ),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          labelText: "اسم المستخدم",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "اسم المستخدم",
                          border: OutlineInputBorder()),
                    ),
                    Container(
                      height: 40,
                    ),
                   ElevatedButton(
                                onPressed: () {
                                 Provider.of<AuthController>(context, listen: false).register({"type":1,"name":controller.text}, context);
                                },
                                style: ElevatedButton.styleFrom(),
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Center(
                                          child: Text(
                                        "تسجيل",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    )),
                              )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
