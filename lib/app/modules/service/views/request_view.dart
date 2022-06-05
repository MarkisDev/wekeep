import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RequestView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RequestView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RequestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
