import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
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
                                // /
                                // print(searchController.text);
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
