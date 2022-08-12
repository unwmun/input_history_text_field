import 'package:flutter/material.dart';
import 'package:input_history_text_field/input_history_text_field.dart';

void main() {
  runApp(MyApp());
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputHistoryTextField(
            historyKey: "01-key",
            listStyle: ListStyle.List,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sampe"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(50),
          child: Column(
            children: <Widget>[
              MyCustomForm(),

              /// sample1
              /// - list
              InputHistoryTextField(
                historyKey: "01",
                listStyle: ListStyle.List,
                validator: (value) {
                  return (value != null && value.contains("@") ? "안돼" : null);
                },
              ),

              /// sample2
              /// - badge
              InputHistoryTextField(
                historyKey: "03",
                listStyle: ListStyle.Badge,
                showHistoryIcon: false,
                backgroundColor: Colors.lightBlue,
                textColor: Colors.white,
                deleteIconColor: Colors.white,
              ),

              /// sample3
              /// - lock item
              InputHistoryTextField(
                historyKey: "04",
                listStyle: ListStyle.Badge,
                lockBackgroundColor: Colors.brown.withAlpha(90),
                lockTextColor: Colors.black,
                lockItems: ['Flutter', 'Rails', 'React', 'Vue'],
                showHistoryIcon: false,
                deleteIconColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.pinkAccent,
              ),

              /// sampe4
              /// - customize
              InputHistoryTextField(
                historyKey: "02",
                minLines: 2,
                maxLines: 10,
                limit: 3,
                enableHistory: true,
                hasFocusExpand: true,
                showHistoryIcon: true,
                showDeleteIcon: true,
                historyIcon: Icons.add,
                deleteIcon: Icons.delete,
                enableOpacityGradient: false,
                listRowDecoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.red, width: 3),
                  ),
                ),
                listDecoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3)),
                  ],
                ),
                historyIconTheme: IconTheme(
                  data: IconThemeData(color: Colors.red, size: 12),
                  child: Icon(Icons.add),
                ),
                deleteIconTheme: IconTheme(
                  data: IconThemeData(color: Colors.blue, size: 12),
                  child: Icon(Icons.remove_circle),
                ),
                listOffset: Offset(0, 5),
                listTextStyle: TextStyle(fontSize: 30),
                historyListItemLayoutBuilder: (controller, value, index) {
                  return InkWell(
                    onTap: () => controller.select(value.text),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              padding: const EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: 5.0,
                                    color: index % 2 == 0
                                        ? Colors.red
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.textToSingleLine,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    value.createdTimeLabel,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Theme.of(context).disabledColor),
                                  ),
                                ],
                              )),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: Theme.of(context).disabledColor,
                          ),
                          onPressed: () {
                            controller.remove(value);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
