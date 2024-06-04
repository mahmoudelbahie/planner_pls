import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner_pls/screens/home_screen.dart';

void main() {
  runApp(PlannerPlsApp());
}

class PlannerPlsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planner PLS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
