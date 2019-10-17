import 'package:credify/Screens/create_group_screen.dart';
import 'package:credify/Components/credify_card.dart';
import 'package:credify/Components/dashboard_card.dart';
import 'package:credify/Screens/travel_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black,
                                ),
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70, bottom: 20),
                          child: CredifyCard(),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateGroupScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(36, 8, 36, 16),
                      child: Container(
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(47, 128, 237, .8)),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/addContactsBackground.png",
                                    height: 170,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        22, 15, 22, 10),
                                    child: Text(
                                      "Create and travel as a group",
                                      style: Theme.of(context)
                                          .accentTextTheme
                                          .display3
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 22, 5),
                                      child: Text(
                                          "- Lower Interest rates and Prices",
                                          style: Theme.of(context)
                                              .accentTextTheme
                                              .display4),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 22, 5),
                                      child: Text("- Better experience",
                                          style: Theme.of(context)
                                              .accentTextTheme
                                              .display4),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TravelScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: DashboardCard(
                        isAtBottom: false,
                        heading: "Travel with us",
                        subheading:
                            "Check amazing packages customised for you. Travel now. Pay later",
                        isDark: true,
                        imageLocation: "assets/images/travel.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
