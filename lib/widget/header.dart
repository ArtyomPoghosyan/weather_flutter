import 'package:flutter/material.dart';
import 'package:wheather/widget/search_bar.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _Header();
}

class _Header extends State<Header> {
  void handleSideBar() {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: Color.fromARGB(255, 216, 206, 67),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => handleSideBar(),
                  child: Icon(Icons.menu),
                ),
                Text.rich(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    TextSpan(children: [
                      TextSpan(
                          text: "WEATHER ",
                          style: TextStyle(color: Colors.white)),
                      WidgetSpan(
                          child: Icon(
                        Icons.sunny_snowing,
                        color: Colors.yellow,
                      )),
                      TextSpan(
                          text: " RADAR", style: TextStyle(color: Colors.white))
                    ])),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchBarScreen()),
                      );
                    },
                    child: Icon(Icons.search))
              ],
            ),
          )),
    );
  }
}
