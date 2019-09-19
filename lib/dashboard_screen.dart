import 'package:credify/credify_card.dart';
import 'package:credify/dashboard_card.dart';
import 'package:credify/travel_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      child: SafeArea(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.people),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 40),
                      child: CredifyCard(
                        cardLevel: "Silver",
                        cardNumber: "1234 5678 9123 4567",
                        name: "Tanmay Joshi",
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
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
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: DashboardCard(
                  isAtBottom: true,
                  heading: "Your Ride. Your Bike",
                  subheading:
                      "Get your bike of dreams. Easy installments. Ride away.",
                  isDark: false,
                  imageLocation: "assets/images/bikeRide.png",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
