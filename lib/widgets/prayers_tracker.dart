import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayersTracker extends StatefulWidget {
  final DateTime startDate;

  PrayersTracker({required this.startDate});

  @override
  _PrayersTrackerState createState() => _PrayersTrackerState();
}

class _PrayersTrackerState extends State<PrayersTracker> {
  List<List<int>> _prayersStatus =
      List.generate(5, (index) => List.generate(7, (index) => 0));
  bool _isTableVisible = true;

  List<String> _generateDates(DateTime startDate) {
    List<String> dates = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = startDate.add(Duration(days: i));
      dates.add(DateFormat('d-M').format(date));
    }
    return dates;
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
                Text('Prayers Tracker',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 11),
          if (_isTableVisible)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
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
                        100.0), // Adjust the width of the first column
                    for (int i = 1; i <= 7; i++) i: FixedColumnWidth(60.0),
                  },
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
                                  [
                                    'Sat',
                                    'Sun',
                                    'Mon',
                                    'Tues',
                                    'Wed',
                                    'Thu',
                                    'Fri'
                                  ][i],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    for (int i = 0; i < 5; i++)
                      TableRow(
                        decoration: BoxDecoration(
                          color: i % 2 == 0 ? Colors.grey[200] : Colors.white,
                        ),
                        children: [
                          Center(
                            child: Text(
                              [
                                'الفجر',
                                'الظهر',
                                'العصر',
                                'المغرب',
                                'العشاء'
                              ][i],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: (i == 0 || i == 1)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: [
                                  const Color.fromARGB(255, 2, 55, 26),
                                  const Color.fromARGB(255, 3, 72, 15),
                                  const Color.fromARGB(255, 3, 72, 6),
                                  const Color.fromARGB(255, 8, 71, 18),
                                  const Color.fromARGB(255, 4, 83, 16)
                                ][i],
                              ),
                            ),
                          ),
                          for (int j = 0; j < 7; j++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _prayersStatus[i][j] =
                                      (_prayersStatus[i][j] + 1) % 3;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40, // Ensuring square shape
                                color: _prayersStatus[i][j] == 1
                                    ? Colors.green
                                    : _prayersStatus[i][j] == 2
                                        ? Colors.red
                                        : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    _prayersStatus[i][j] == 1
                                        ? '✓'
                                        : _prayersStatus[i][j] == 2
                                            ? 'X'
                                            : '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _prayersStatus[i][j] == 2
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
