import 'package:flutter/material.dart';
import 'package:SnapTrash/pages/loginSignin/logout/logout.dart';

class LocalReports extends StatefulWidget {
  const LocalReports({super.key});

  @override
  State<LocalReports> createState() => _LocalReportsState();
}

class _LocalReportsState extends State<LocalReports> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: logout()),
    );
  }
}
