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
  List<String> tableValues2 = List.generate(15, (_) => '');
  List<String> table2Values1 =
      List.generate(15, (index) => (index + 16).toString());
  List<String> table2Values2 = List.generate(15, (_) => '');

  int lastFilledCellIndex1 = -1;
  int lastFilledCellIndex2 = -1;
  int lastNumberIndex1 = -1;
  int lastNumberIndex2 = -1;
  bool isTable1Active = true;

  bool sumEquals9(List<String> values) {
    int sum = 0;
    for (String value in values) {
      sum += int.tryParse(value) ?? 0;
    }
    return sum == 9;
  }

  void resetLastCell() {
    if (isTable1Active && lastFilledCellIndex1 >= 0) {
      tableValues2[lastFilledCellIndex2 + 1] = '';
      lastFilledCellIndex1--;
    } else if (!isTable1Active && lastFilledCellIndex2 >= 0) {
      table2Values2[lastFilledCellIndex2] = '';
      lastFilledCellIndex2--;
      lastNumberIndex2 = -1; // Reset last number index when cell is deleted
    }
  }

  void switchTables() {
    setState(() {
      isTable1Active = !isTable1Active;
    });
  }

  int getSum() {
    int sum = 0;
    for (String value in tableValues2) {
      sum += int.tryParse(value) ?? 0;
    }
    for (String value in table2Values2) {
      sum += int.tryParse(value) ?? 0;
    }
    return sum;
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
                    if (isTable1Active) {
                      lastFilledCellIndex1++;
                      tableValues2[lastFilledCellIndex1] = buttonValues1[index];
                      if (lastFilledCellIndex1 >= 14) switchTables();
                    } else {
                      lastFilledCellIndex2++;
                      table2Values2[lastFilledCellIndex2] =
                          buttonValues1[index];
                      if ((lastFilledCellIndex2 + 16) % 9 == 0)
                        lastNumberIndex2 = lastFilledCellIndex2;
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
                      if (isTable1Active) {
                        lastFilledCellIndex1++;
                        tableValues2[lastFilledCellIndex1] =
                            buttonValues2[index];
                        if (lastFilledCellIndex1 >= 14) switchTables();
                      } else {
                        lastFilledCellIndex2++;
                        table2Values2[lastFilledCellIndex2] =
                            buttonValues2[index];
                        if ((lastFilledCellIndex2 + 16) % 9 == 0)
                          lastNumberIndex2 = lastFilledCellIndex2;
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
                    if (isTable1Active) {
                      lastFilledCellIndex1++;
                      tableValues2[lastFilledCellIndex1] = buttonValues2[4];
                      if (lastFilledCellIndex1 >= 14) switchTables();
                    } else {
                      lastFilledCellIndex2++;
                      table2Values2[lastFilledCellIndex2] = buttonValues2[4];
                      if ((lastFilledCellIndex2 + 16) % 9 == 0)
                        lastNumberIndex2 = lastFilledCellIndex2;
                    }
                  });
                },
                child: Text('0'),
              ),
            ],
          ),
          SizedBox(height: 32),
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
                        textAlign: TextAlign.center,
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
                        tableValues2[i],
                        textAlign: TextAlign.center,
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
                        table2Values1[i],
                        textAlign: TextAlign.center,
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
                        table2Values2[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isTable1Active
                              ? null
                              : (i == lastNumberIndex2 ? Colors.green : null),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'SUM: ${getSum()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
