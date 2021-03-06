import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:receipe/model/recepieModel.dart';
import 'package:receipe/recipeView.dart';
import 'package:receipe/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  List<ReceipeModel> receipeList = [];
  List<Map> categoryList = [
    {
      'category': 'pickels',
      'image':
          'https://images.pexels.com/photos/1414693/pexels-photo-1414693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    },
    {
      'category': 'sweet',
      'image':
          'https://images.pexels.com/photos/8659010/pexels-photo-8659010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    },
  ];
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
    getData('momo');
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
                                  Navigator.push(
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
                  // Header Text
                  SizedBox(
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
                    child: isLoading
                        ? CircularProgressIndicator()
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
                                                receipeList[index].appUrl,
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
                                                .appLabel
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
                  Container(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: Image.network(
                                    categoryList[index]['image'].toString(),
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 200,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius:
                                            BorderRadius.circular(14.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          categoryList[index]['category'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Container(),
                              ],
                            ),
                          );
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
