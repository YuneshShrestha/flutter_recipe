import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:receipe/model/recepieModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<ReceipeModel> receipeList = [];
  void getData(String query) async {
    var response = await http.get(Uri.parse(
        "https://api.edamam.com/api/recipes/v2?q=$query&app_key=%2007df7c7836c9fb2ecf5ecd3fb5216c61&_cont=CHcVQBtNNQphDmgVQntAEX4BZktxAAAFRmNDAmEQYVZ6AwcCUXlSVmQbNVciB1FVRWERCzQWZQN1AgIDRGFFUjcaMV1zAVcVLnlSVSBMPkd5BgMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D&type=public&app_id=76632e52"));
    Map data = jsonDecode(response.body);
    List hitsData = data['hits'];
    if (response.statusCode == 200) {
      for (var element in hitsData) {
        ReceipeModel receipeModel = ReceipeModel();
        receipeModel = ReceipeModel.factoryforMap(element);
        receipeList.add(receipeModel);
      }
      for (ReceipeModel element in receipeList) {
        print(element.appLabel);
      }
    } else {
      print("Problem Detected");
    }
  }

  @override
  void initState() {
    super.initState();
    getData('chicken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff213A50), Color(0xff071938)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  // Search bar
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if ((searchController.text)
                                        .replaceAll(" ", "") ==
                                    "") {
                                  print("Please fill search");
                                } else {
                                  setState(() {
                                    getData(searchController.text);
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: "What do you want to cook today?",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Header Text
                  Container(
                    child: Column(
                      children: const [
                        Text(
                          "Let's Cook Something Delicious!!!",
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.6,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Cravy, Sweet, Flavorsome",
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        )
                      ],
                    ),
                  ),
                  // List Widget
                  SizedBox(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1200,
                        itemBuilder: (BuildContext context, int index) {
                          return Text("Hello $index");
                        }),
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
