import 'package:flutter/material.dart';
import 'package:SnapTrash/pages/loginSignin/logout/logout.dart';

class localReports extends StatefulWidget {
  const localReports({super.key});

  @override
  State<localReports> createState() => _localReportsState();
}

class _localReportsState extends State<localReports> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: logout()),
    );
  }
}
