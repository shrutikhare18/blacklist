 import 'package:flutter/material.dart';

/// Just a dummy list of names.
var listOfNames = [

  "Bolero MP 0353",
  "SUV UP 3456",

];

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // A temporary list to store the search results.
  List<String> _tempList = List<String>();
  TextEditingController _addNameController;

  @override
  void initState() {
    super.initState();
    _addNameController = TextEditingController();

    /// At start [_tempList] will be same as [listOfNames]
    _tempList.addAll(listOfNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blacklist'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _addNameController,
                    onChanged: (String searchString) {
                      // First name sure that the searchString is not empty.
                      if (searchString.isNotEmpty) {
                        // Now clear the _tempList.
                        _tempList.clear();

                        // Following code loops over all the string in listOfNames and check if any of them matches with the searchString.
                        // Those that do match are them added to _tempList.
                        listOfNames.forEach(
                              (name) {
                            // Here we first convert both the strings being compared to lower case.
                            if (name
                                .toLowerCase()
                                .contains(searchString.toLowerCase())) {
                              _tempList.add(name);
                            }
                          },
                        );
                      } else {
                        // If search string is empty, reset _tempList with listOfNames, because we want to display everything.
                        _tempList.clear();
                        _tempList.addAll(listOfNames);
                      }
                      // Call setState at the end to rebuild everything.
                      setState(() {});
                    },
                  ),
                ),
              ),
              RaisedButton(
                child: Text("ADD"),
                onPressed: () {
                  setState(() {
                    // When add button is pressed. Match sure that search text is not empty.
                    // If it is not empty, add the string to listOfNames. Then copy listOfNames to _tempList.
                    // Finally clear the search field.
                    if (_addNameController.text.isNotEmpty) {
                      listOfNames.add(_addNameController.text);
                      _tempList.clear();
                      _tempList.addAll(listOfNames);
                      _addNameController.clear();
                    }
                  });
                },
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tempList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_tempList.elementAt(index)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}