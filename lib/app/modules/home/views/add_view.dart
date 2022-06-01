import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';

class AddView extends StatelessWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: appBar,
      body: Column(children: [
        Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is not valid!';
                } else {
                  return null;
                }
                ;
              },
            )
          ]),
        )
      ]),
    );
  }
}
