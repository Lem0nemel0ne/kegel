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
  int nextButtonCount = 0;

  void storeTables() {
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
      if (nextButtonCount == 0) {
        clearTables();
      }
      nextButtonCount++;
      if (nextButtonCount > 4) {
        storeTables();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EndScreen(storedValues)),
        );
      } else {
        if (tableValues2.length < tableValues1.length) {
          tableValues2.addAll(buttonValues1);
        } else {
          table2Values2.addAll(buttonValues1);
        }
      }
    });
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
                    });
                  },
                  child: Text((index + 6).toString()),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    buttonValues2[4] = '0';
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
                        tableValues2.length > i ? tableValues2[i] : '',
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
                        table2Values2.length > i ? table2Values2[i] : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: onButtonClick,
                child: Text('Näste Bahn'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EndScreen extends StatelessWidget {
  final List<String> storedValues;

  EndScreen(this.storedValues);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('End Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stored Values:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: storedValues.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(storedValues[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
