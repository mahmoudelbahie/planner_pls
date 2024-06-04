import 'package:flutter/material.dart';
import 'package:planner_pls/widgets/week_top_goals.dart';
import 'package:planner_pls/widgets/week_challenge.dart';
import 'package:planner_pls/widgets/prayers_tracker.dart';
import 'package:planner_pls/widgets/good_deeds_tracker.dart';
import 'package:planner_pls/widgets/health_tracker.dart';
import 'package:planner_pls/widgets/self_care_tracker.dart';
import 'package:planner_pls/widgets/notes_and_ideas.dart';
import 'package:planner_pls/widgets/rate_your_week.dart';

class WeekCalendarTracker extends StatefulWidget {
  @override
  _WeekCalendarTrackerState createState() => _WeekCalendarTrackerState();
}

class _WeekCalendarTrackerState extends State<WeekCalendarTracker> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Week Calendar Tracker'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text("Select Start Date"),
              ),
              Text("Selected date: ${_selectedDate.toLocal()}".split(' ')[0]),
              SizedBox(height: 20),
              WeekTopGoals(),
              WeekChallenge(),
              PrayersTracker(startDate: _selectedDate),
              GoodDeedsTracker(startDate: _selectedDate),
              HealthTracker(startDate: _selectedDate),
              SelfCareTracker(),
              NotesAndIdeas(),
              RateYourWeek(),
            ],
          ),
        ),
      ),
    );
  }
}
