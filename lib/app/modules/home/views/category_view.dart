import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CategoryView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CategoryView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CategoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
