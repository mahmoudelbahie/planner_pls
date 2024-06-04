import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoodDeedsTracker extends StatefulWidget {
  final DateTime startDate;

  GoodDeedsTracker({required this.startDate});

  @override
  _GoodDeedsTrackerState createState() => _GoodDeedsTrackerState();
}

class _GoodDeedsTrackerState extends State<GoodDeedsTracker> {
  final List<List<int>> _goodDeedsStatus =
      List.generate(7, (index) => List.generate(7, (index) => 0));
  final List<List<String>> _textFieldValues =
      List.generate(7, (index) => List.generate(7, (index) => ''));

  bool _isTableVisible = true; // Define _isTableVisible

  List<String> _generateDates(DateTime startDate) {
    List<String> dates = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = startDate.add(Duration(days: i));
      dates.add(DateFormat('d-M').format(date));
    }
    return dates;
  }

  void _showActionDialog(int i, int j) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose Action"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  setState(() {
                    _goodDeedsStatus[i][j] = 1;
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _goodDeedsStatus[i][j] = 2;
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showTextFieldDialog(i, j);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTextFieldDialog(int i, int j) {
    TextEditingController _controller =
        TextEditingController(text: _textFieldValues[i][j]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Text"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter your note"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _textFieldValues[i][j] = _controller.text;
                  _goodDeedsStatus[i][j] = 3;
                });
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> dates = _generateDates(widget.startDate);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
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
                Text('Good Deeds',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 11),
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: {
                    0: const FixedColumnWidth(150.0),
                    for (int i = 1; i <= 7; i++)
                      i: const FixedColumnWidth(100.0),
                  },
                  children: [
                    TableRow(
                      children: [
                        const SizedBox.shrink(), // Empty cell
                        for (int i = 0; i < 7; i++)
                          Column(
                            children: [
                              Text(
                                dates[i],
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Center(
                                child: Text(
                                  ['S', 'S', 'M', 'T', 'W', 'T', 'F'][i],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    for (int i = 0; i < 7; i++)
                      TableRow(
                        decoration: BoxDecoration(
                          color: i % 2 == 0 ? Colors.green[100] : Colors.white,
                        ),
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                [
                                  'Family Care',
                                  'Sunnah Prayers',
                                  'Recite Qur\'an',
                                  'Zekr & making Duaa',
                                  'Fasting',
                                  'Donation',
                                  'Help Others'
                                ][i],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          for (int j = 0; j < 7; j++)
                            GestureDetector(
                              onTap: () => _showActionDialog(i, j),
                              child: Container(
                                constraints:
                                    BoxConstraints(minWidth: 80, maxWidth: 200),
                                decoration: BoxDecoration(
                                  color: _goodDeedsStatus[i][j] == 1
                                      ? Colors.green
                                      : _goodDeedsStatus[i][j] == 2
                                          ? Colors.red
                                          : Colors.transparent,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Center(
                                  child: _goodDeedsStatus[i][j] == 3
                                      ? Container(
                                          constraints: BoxConstraints(
                                              minWidth: 40, maxWidth: 200),
                                          padding: EdgeInsets.all(1.0),
                                          child: Text(
                                            _textFieldValues[i][j],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  'Comic Sans MS', // Fun font
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: null,
                                          ),
                                        )
                                      : Text(
                                          _goodDeedsStatus[i][j] == 1
                                              ? '✓'
                                              : _goodDeedsStatus[i][j] == 2
                                                  ? 'X'
                                                  : '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                'Comic Sans MS', // Fun font
                                            color: _goodDeedsStatus[i][j] == 2
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
