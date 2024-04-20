import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageUi extends StatefulWidget {
  const HomePageUi({super.key});

  @override
  State<HomePageUi> createState() => _HomePageUiState();
}

class _HomePageUiState extends State<HomePageUi> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        return;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FutureBuilder(
                future: context.read<AuthRegisterProvider>().readNameToCache(),
                builder: (context, snapshot) {
                  String name = snapshot.data.toString().firstElement;
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text("Hello $name, welcome to application!");
                  } else {
                    return const Center();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
