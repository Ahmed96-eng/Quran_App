import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_app/model/quran.dart';

import 'package:quran_app/screens/sura_details.dart';

class SuraList extends StatefulWidget {
  @override
  _SuraListState createState() => _SuraListState();
}

class _SuraListState extends State<SuraList> {
  Future<QuranModel> fetchQuranList;
  @override
  void initState() {
    fetchQuranList = fetchQuranModel();

    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: new Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text("Are You Sure?"),
            actions: <Widget>[
              FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
              FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  "No",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[800],
          body: FutureBuilder<QuranModel>(
            future: fetchQuranList,
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.data.surahs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Card(
                              margin: EdgeInsets.all(5),
                              color: Colors.grey[900],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(snapshot
                                        .data.data.surahs[index].number
                                        .toString()),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                  title: Text(
                                      snapshot
                                          .data.data.surahs[index].englishName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.028,
                                        color: Colors.white,
                                      )),
                                  trailing: Text(
                                      snapshot.data.data.surahs[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.028,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuraDetails(
                                            name: snapshot
                                                .data.data.surahs[index].name,
                                            englishName: snapshot.data.data
                                                .surahs[index].englishName,
                                            ayahList: snapshot
                                                .data.data.surahs[index].ayahs,
                                          )));
                            },
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
