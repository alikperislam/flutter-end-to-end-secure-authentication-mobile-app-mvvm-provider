import 'package:enguide_app/src/features/splash/view/ui/loading_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

mixin LoadingPageMixin on State<LoadingPageUi> {
  String? data;
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<String?> initializeData() async {
    final token = await getData();
    data = token;
    return data;
  }

  Future<String?> getData() async {
    var box = await Hive.openBox('TokenStorage');
    return box.get('user')?.token;
  }
}
