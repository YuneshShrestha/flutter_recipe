import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:receipe/model/recepieModel.dart';
import 'package:receipe/recipeView.dart';

class Search extends StatefulWidget {
  String? search;
  Search({Key? key, this.search}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;
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

        setState(() {
          isLoading = false;
        });
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
    getData(widget.search!);
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Search(
                                                search: searchController.text,
                                              )));
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

                  // List Widget
                  SizedBox(
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: receipeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecipeView(
                                                receipeList[index].appLabel,
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14.0)),
                                  elevation: 0.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                        child: Image.network(
                                          receipeList[index]
                                              .imageUrl
                                              .toString(),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(14.0),
                                                  bottomRight:
                                                      Radius.circular(14.0))),
                                          child: Text(
                                            receipeList[index]
                                                .appUrl
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                            width: 100.0,
                                            height: 40.0,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(16.0),
                                                    bottomLeft:
                                                        Radius.circular(4.0))),
                                            child: Center(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .local_fire_department,
                                                      size: 18.0,
                                                    ),
                                                    Text(
                                                      receipeList[index]
                                                          .calories
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ]),
                                            )),
                                      ),
                                      Container(),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                  // Text(categoryList[0]['category'])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
