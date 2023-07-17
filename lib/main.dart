import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Table Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtonTablePage(),
    );
  }
}

class ButtonTablePage extends StatefulWidget {
  @override
  _ButtonTablePageState createState() => _ButtonTablePageState();
}

class _ButtonTablePageState extends State<ButtonTablePage> {
  List<String> buttonValues1 = List.filled(5, '');
  List<String> buttonValues2 = List.filled(5, '');
  List<String> tableValues1 =
      List.generate(15, (index) => (index + 1).toString());
  List<String> tableValues2 = [];
  List<String> table2Values1 =
      List.generate(15, (index) => (index + 16).toString());
  List<String> table2Values2 = [];
  List<String> storedValues = [];
  List<List<String>> savedTables = [];

  bool showNextButton = false;
  int totalSum = 0;
  int round = 1;

  void storeValues() {
    storedValues.clear();
    storedValues.addAll(tableValues2);
    storedValues.addAll(table2Values2);
  }

  void clearTables() {
    tableValues2.clear();
    table2Values2.clear();
  }

  void onButtonClick() {
    setState(() {
      clearTables();
      storeValues();
      showNextButton = false;
      totalSum = 0;
      round++;

      if (round > 4) {
        savedTables.add([
          ...tableValues1,
          ...tableValues2,
          ...table2Values1,
          ...table2Values2
        ]);
      }
    });
  }

  void onBackButtonClick() {
    setState(() {
      if (table2Values2.isNotEmpty) {
        int value = int.parse(table2Values2.removeLast());
        totalSum -= value;
      } else if (tableValues2.isNotEmpty) {
        int value = int.parse(tableValues2.removeLast());
        totalSum -= value;
      }
    });
  }

  void onViewTablesClick() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Saved Tables'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < savedTables.length; i++)
                Column(
                  children: [
                    Text('Round ${i + 1}'),
                    SizedBox(height: 8),
                    Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        for (int i = 0; i < 15; i++) i: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          children: [
                            for (int i = 0; i < 15; i++)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  savedTables[i][i],
                                ),
                              ),
                          ],
                        ),
                        TableRow(
                          children: [
                            for (int i = 0; i < 15; i++)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  savedTables[i][i + 15],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  savedTables.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Table Example'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) => ElevatedButton(
                onPressed: () {
                  setState(() {
                    buttonValues1[index] = (index + 1).toString();
                    if (tableValues2.length < table2Values1.length) {
                      tableValues2.add(buttonValues1[index]);
                      totalSum += int.parse(buttonValues1[index]);
                    } else {
                      table2Values2.add(buttonValues1[index]);
                      totalSum += int.parse(buttonValues1[index]);
                    }
                    if (tableValues2.length == table2Values1.length &&
                        table2Values2.length == table2Values1.length) {
                      showNextButton = true;
                    }
                  });
                },
                child: Text((index + 1).toString()),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(
                4,
                (index) => ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonValues2[index] = (index + 6).toString();
                      if (tableValues2.length < table2Values1.length) {
                        tableValues2.add(buttonValues2[index]);
                        totalSum += int.parse(buttonValues2[index]);
                      } else {
                        table2Values2.add(buttonValues2[index]);
                        totalSum += int.parse(buttonValues2[index]);
                      }
                      if (tableValues2.length == table2Values1.length &&
                          table2Values2.length == table2Values1.length) {
                        showNextButton = true;
                      }
                    });
                  },
                  child: Text((index + 6).toString()),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    buttonValues2[4] = '0';
                    if (tableValues2.length < table2Values1.length) {
                      tableValues2.add(buttonValues2[4]);
                      totalSum += int.parse(buttonValues2[4]);
                    } else {
                      table2Values2.add(buttonValues2[4]);
                      totalSum += int.parse(buttonValues2[4]);
                    }
                    if (tableValues2.length == table2Values1.length &&
                        table2Values2.length == table2Values1.length) {
                      showNextButton = true;
                    }
                  });
                },
                child: Text('0'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Table(
            border: TableBorder.all(),
            columnWidths: {
              for (int i = 0; i < 15; i++) i: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  for (int i = 0; i < 15; i++)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        tableValues1[i],
                      ),
                    ),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 0; i < 15; i++)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        tableValues2.length > i ? tableValues2[i] : '',
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Table(
            border: TableBorder.all(),
            columnWidths: {
              for (int i = 0; i < 15; i++) i: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  for (int i = 0; i < 15; i++)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        table2Values1.length > i ? table2Values1[i] : '',
                      ),
                    ),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 0; i < 15; i++)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        table2Values2.length > i ? table2Values2[i] : '',
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Total Sum: $totalSum',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Round: $round',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onBackButtonClick,
                child: Text('Back'),
              ),
              ElevatedButton(
                onPressed: showNextButton ? onButtonClick : null,
                child: Text('Näste Bahn'),
              ),
              ElevatedButton(
                onPressed: round > 4 ? onViewTablesClick : null,
                child: Text('View Tables'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
