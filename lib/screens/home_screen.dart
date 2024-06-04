import 'package:flutter/material.dart';
import 'package:planner_pls/widgets/week_overview.dart';
import 'package:planner_pls/widgets/daily_planner.dart';
import 'package:planner_pls/widgets/monthly_challenge.dart';
import 'package:planner_pls/widgets/brain_dump.dart';
import 'week_calendar_tracker.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner PLS Home'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WeekOverview(),
            DailyPlanner(),
            MonthlyChallenge(),
            BrainDump(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeekCalendarTracker()),
                );
              },
              child: Text('Go to Week Calendar Tracker'),
            ),
          ],
        ),
      ),
    );
  }
}
