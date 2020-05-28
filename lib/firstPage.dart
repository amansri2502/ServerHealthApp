import 'package:flutter/material.dart';
import './radial_progress.dart';
import './model/node.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var _isLoading = false;
  List<Node> _nodes = [
    // Node(cpu: 0.4, memory: 0.8, isLeader: true),
    // Node(cpu: 0.4, memory: 0.2),
    // Node(cpu: 0.2, memory: 0.5)
  ];

  // void add() {
  //   const url = "https://mini-bc8a1.firebaseio.com/nodes.json";
  //   http.post(url,
  //       body: json.encode({'cpu': 0.5, 'memory': 0.5, '_isleader': false}));
  // }
  Future<void> fetch() async {
    const url = "https://394e8e37.ngrok.io/frontApi";
    final response = await http.get(url);

    final extractData = json.decode(response.body) ;
      final extractedData =json.decode(extractData) as Map<String, dynamic>;
  
    // final extractedData={"CmdID":0,"Index":1,"Term":1,"Data":"Tk9Q","NodeHealth":{"127.0.0.1:53041":{"cpuusage":43.56435643564357,"memeoryusage":63.49983215332031,"status":1},"127.0.0.1:53042":{"cpuusage":50,"memeoryusage":63.56949806213379,"status":1},"127.0.0.1:53043":{"cpuusage":49,"memeoryusage":63.509559631347656,"status":1}},"State":"Commited","VotedFor":"127.0.0.1:53041"} as Map<String, dynamic>;
    List<Node> value = [];
   final leaderIp =extractedData["VotedFor"];
    extractedData["NodeHealth"].forEach((key, v) {
      value.add(
          Node(cpu: v['cpuusage']/100, memory: v['memeoryusage']/100,isLeader:leaderIp==key?true:false ));
    });
    
     setState(() {
        _nodes = value;
      });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    fetch().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    fetch().then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _isLoading = true;
          });
          return fetch().then((_) {
            setState(() {
              _isLoading = false;
            });
          });
        },
        child: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.network(
                        "https://rendr.com.au/wp-content/uploads/2018/10/Website-Maintenance-Animation.gif",
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    color: Colors.white12,
                  ),
                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 80),
                        Card(
                          elevation: 4,
                          child: Container(
                            width: 190,
                            height: 165,
                            color: Colors.white.withOpacity(0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        RadialProgress(_nodes[0].cpu),
                                        SizedBox(height: 10),
                                        Text(
                                          "CPU",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: "Lato"),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        RadialProgress(_nodes[0].memory),
                                        SizedBox(height: 10),
                                        Text(
                                          "MEMORY",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: "Lato"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 25),
                                    Text(
                                      "NODE 1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          fontFamily: "Lato"),
                                    ),
                                    _nodes[0].isLeader == true
                                        ? Text(
                                            "Leader",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                fontFamily: "Lato"),
                                          )
                                        : Text("Follower")
                                  ],
                                )
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Card(
                              margin: EdgeInsets.only(left: 10, top: 16),
                              elevation: 4,
                              child: Container(
                                width: 160,
                                height: 170,
                                color: Colors.white.withOpacity(0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            RadialProgress(_nodes[1].cpu),
                                            SizedBox(height: 10),
                                            Text(
                                              "CPU",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: "Lato"),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            RadialProgress(_nodes[1].memory),
                                            SizedBox(height: 10),
                                            Text(
                                              "MEMORY",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: "Lato"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          "NODE 2",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              fontFamily: "Lato"),
                                        ),
                                        _nodes[1].isLeader == true
                                            ? Text(
                                                "Leader",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: "Lato"),
                                              )
                                            : Text(
                                                "Follower",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: "Lato"),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Card(
                              margin:
                                  EdgeInsets.only(left: 5, right: 10, top: 16),
                              elevation: 4,
                              child: Container(
                                width: 160,
                                height: 170,
                                color: Colors.white.withOpacity(0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            RadialProgress(_nodes[2].cpu),
                                            SizedBox(height: 10),
                                            Text(
                                              "CPU",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: "Lato"),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            RadialProgress(_nodes[2].memory),
                                            SizedBox(height: 10),
                                            Text(
                                              "MEMORY",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: "Lato"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(height: 25),
                                        Text(
                                          "NODE 3",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              fontFamily: "Lato"),
                                        ),
                                        _nodes[2].isLeader == true
                                            ? Text(
                                                "Leader",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: "Lato"),
                                              )
                                            : Text(
                                                "Follower",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: "Lato"),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 20),
                          child: Align(
                            heightFactor: screenHeight / 180,
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              elevation: 6,
                              child: Icon(Icons.refresh),
                              backgroundColor: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                fetch().then((_) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
