import 'package:flutter/material.dart';

class CitySelection extends StatefulWidget {
  @override
  State<CitySelection> createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  final TextEditingController _textController = TextEditingController();
  final _cityList = <String>[
    'Jakarta',
    'Cikarang',
    'Chicago',
    'Surabaya',
    'Bandung',
    'Malang',
    'Cibubur',
    'Aceh',
    'Denpasar',
    'Depok',
    'San Fransisco',
    'Florida',
    'Detroit',
    'Delhi',
    'Shibuya',
    'Tokyo',
    'Gorontalo',
    'Moskow',
    'Kuala Lumpur',
    'Hamburg',
    'Hawaii',
    'Singapura',
    'Seoul',
    'Yogyakarta',
    'Jayapura',
    'Karawang',
    'Lampung',
    'Palembang',
    'Laos',
    'Ohio',
    'New York',
    'Nevada',
    'Oregon',
    'Rangkasbitung',
    'Singaraja',
    'Singkawang',
    'Tomohon',
    'Tambun',
    'Tangerang',
    'Salatiga',
    'Solo'
  ];
  List<String> query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find City'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          query = _cityList
                              .where((each) => each
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList(growable: false);
                        });
                      },
                      focusNode: FocusNode(canRequestFocus: false),
                      controller: _textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        hintText: 'Input CityName',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.pop(context, _textController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (query != null && query.isNotEmpty)
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: query.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _textController.value =
                              TextEditingValue(text: query[index]);
                          FocusScope.of(context).unfocus();
                        },
                        child: Card(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                              child: Text('${query[index]}')),
                        ),
                      );
                    }),
              ),
            )
          else
            Expanded(
              flex: 8,
              child: Container(),
            )
        ],
      ),
    );
  }
}
