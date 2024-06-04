import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HealthTracker extends StatefulWidget {
  final DateTime startDate;

  HealthTracker({required this.startDate});

  @override
  _HealthTrackerState createState() => _HealthTrackerState();
}

class _HealthTrackerState extends State<HealthTracker> {
  List<List<int>> _healthStatus =
      List.generate(4, (index) => List.generate(7, (index) => 0));
  List<String> _healthRoutines = [
    'Healthy food',
    '8 glass of water',
    'Workout or GYM',
    '7 hours of sleep'
  ];
  bool _isTableVisible = true;

  final List<String> _healthSuggestions = [
    'Go for a walk',
    'Yoga session',
    'Meditation',
    'Drink green tea',
    'Avoid sugar',
    'Sleep early',
    'Eat more fruits',
    'Drink enough water'
  ];

  List<String> _generateDates(DateTime startDate) {
    List<String> dates = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = startDate.add(Duration(days: i));
      dates.add(DateFormat('d-M').format(date));
    }
    return dates;
  }

  void _addNewRow() {
    setState(() {
      _healthRoutines.add(_healthSuggestions[
          _healthRoutines.length % _healthSuggestions.length]);
      _healthStatus.add(List.generate(7, (index) => 0));
    });
  }

  void _removeRow(int index) {
    setState(() {
      _healthRoutines.removeAt(index);
      _healthStatus.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dates = _generateDates(widget.startDate);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isTableVisible = !_isTableVisible;
              });
            },
            child: Row(
              children: [
                Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.blue, size: 16),
                    SizedBox(height: 4),
                  ],
                ),
                SizedBox(width: 4),
                Text('Health Tracker',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNewRow,
                ),
              ],
            ),
          ),
          SizedBox(height: 11),
          if (_isTableVisible)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: {
                    0: FixedColumnWidth(
                        180.0), // Increase the width of the first column
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        SizedBox.shrink(), // Empty cell
                        for (int i = 0; i < 7; i++)
                          Column(
                            children: [
                              Text(
                                dates[i],
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Center(
                                child: Text(
                                  ['S', 'S', 'M', 'T', 'W', 'T', 'F'][i],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    for (int i = 0; i < _healthRoutines.length; i++)
                      TableRow(
                        decoration: BoxDecoration(
                          color: i % 2 == 0 ? Colors.green[100] : Colors.white,
                        ),
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: _healthRoutines[i],
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _healthRoutines[i] = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeRow(i),
                              ),
                            ],
                          ),
                          for (int j = 0; j < 7; j++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _healthStatus[i][j] =
                                      (_healthStatus[i][j] + 1) % 3;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40, // Ensuring square shape
                                color: _healthStatus[i][j] == 1
                                    ? Colors.green
                                    : _healthStatus[i][j] == 2
                                        ? Colors.red
                                        : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    _healthStatus[i][j] == 1
                                        ? '✓'
                                        : _healthStatus[i][j] == 2
                                            ? 'X'
                                            : '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _healthStatus[i][j] == 2
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
