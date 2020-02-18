import 'package:flutter/material.dart';
import 'package:hello_world/CityCard.dart';
import 'package:hello_world/CustomAppBar.dart';
import 'package:hello_world/CustomShapeClipper.dart';
import 'package:hello_world/ChoiceChip.dart' as CustomChoiceChip;

void main() => runApp(MaterialApp(
      title: 'Flight list mock up',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: appTheme,
    ));

Color firstColor = Color(0xFF9C27B0);
Color secondColor = Color(0xFFCE93D8);

ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFF9C27B0), fontFamily: 'Oxygen');

List<String> locations = ['LAGOS (LOS)', 'ABUJA (ABJ)'];

const TextStyle dropDownLabelStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 18.0);
var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body:
          Column(children: <Widget>[HomeScreenTopPart(), homeScreenBottomPart]),
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationIndex = 0;
  var isFlightSelected = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor],
              ),
            ),
            child: Column(children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    SizedBox(width: 16.0),
                    PopupMenuButton(
                      onSelected: (index) {
                        setState(() {
                          selectedLocationIndex = index;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            locations[selectedLocationIndex],
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white)
                        ],
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<int>>[
                        PopupMenuItem(
                            child: Text(locations[0],
                                style: dropDownMenuItemStyle),
                            value: 0),
                        PopupMenuItem(
                            child: Text(locations[1],
                                style: dropDownMenuItemStyle),
                            value: 1)
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                'Where would\nyou want to go?',
                style:
                    TextStyle(fontSize: 24.0, color: Colors.white, height: 1.2),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: TextField(
                    controller: TextEditingController(text: locations[0]),
                    style: dropDownMenuItemStyle,
                    cursorColor: appTheme.primaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 5.0),
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: CustomChoiceChip.ChoiceChip(
                          Icons.flight_takeoff, 'Flights', isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = true;
                        });
                      },
                    ),
                    SizedBox(width: 20.0),
                    InkWell(
                      child: CustomChoiceChip.ChoiceChip(
                          Icons.hotel, 'Hotels', !isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = false;
                        });
                      },
                    )
                  ])
            ]),
          ),
        )
      ],
    );
  }
}

var homeScreenBottomPart = Container(
  child: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Currently watched items', style: dropDownMenuItemStyle),
              Spacer(),
              Text('VIEW ALL(12)', style: viewAllStyle)
            ]),
      ),
      Container(
        height: 240.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: cityCards,
        ),
      ),
    ],
  ),
);
