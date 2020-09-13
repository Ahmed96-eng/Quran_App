import 'package:flutter/material.dart';
import 'package:quran_app/model/quran.dart';

class SuraDetails extends StatefulWidget {
  List<Ayah> ayahList;
  String name, englishName;

  SuraDetails({this.name, this.englishName, this.ayahList});

  @override
  _SuraDetailsState createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.grey[900],
              title: Text(widget.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.045,
                      color: Colors.white)),
              pinned: true,
              expandedHeight: height * 0.25,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  "https://i.pinimg.com/originals/21/51/52/2151525a8e903796bd347660be0ef3e2.jpg" ??
                      "",
                  fit: BoxFit.cover,
                ),
              )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      color: Colors.grey[900],
                      height: height,
                      child: ListView.builder(
                        itemCount: widget.ayahList.length,
                        itemBuilder: (context, index) => ListTile(
                          // contentPadding: EdgeInsets.all(5),
                          title: Text(widget.ayahList[index].text,
                              textAlign: TextAlign.end,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white)),
                          trailing: Text(
                            "${widget.ayahList[index].numberInSurah.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                childCount: widget.ayahList.length),
          )
        ],
      ),
    ));
  }
}

//  SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: <Widget>[
// Container(
//   height: MediaQuery.of(context).size.height * 0.85,
//   child: ListView.builder(
//     itemCount: widget.ayahList.length,
//     itemBuilder: (context, index) => ListTile(
//       contentPadding: EdgeInsets.all(10),
//       title: Text(
//         widget.ayahList[index].text,
//         textAlign: TextAlign.end,
//       ),
//       trailing:
//           Text(widget.ayahList[index].numberInSurah.toString()),
//     ),
//   ),
// ),
//               Container(
//                 height: MediaQuery.of(context).size.width * 0.15,
//                 // width: MediaQuery.of(context).size.width * 0.20,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Icon(Icons.ac_unit),
//                     Icon(Icons.access_time),
//                     Icon(Icons.account_balance),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
