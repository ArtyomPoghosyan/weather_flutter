import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wheather/screen/base_screen.dart';
// import 'package:wheather/screen/main_screen.dart';
import 'package:wheather/utils/helpers.dart';

import '../service/index.dart';
import '../store/common.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({Key? key}) : super(key: key);

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  late TextEditingController _controller;
  CommonStore commonStore = CommonStore();
  String? errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleSearch(String value) {
    commonStore.setCityName(value);
  }

  Future handleSearchCity() async {
    final cityName = _controller.text.trimRight();
    print('${_controller.text.trimRight()}mmmmm');
    print('${cityName}tyyyyyyyyoooommmmm');
    final response = await WeatherService.getCurrentCityWeatherData(cityName);
    if (response is List) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BaseScreen(),
        ),
      );
      errorText = null;
      setState(() {});
    } else {
      errorText = response['message'].toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  TextField(
                    controller: _controller,
                    onChanged: handleSearch,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 13,
                    child: InkWell(
                      onTap: () {
                        log("tyom");
                        Helper.getLocation(true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BaseScreen()),
                        );
                      },
                      child: Icon(
                        Icons.location_searching,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: handleSearchCity, child: Text("Search")),
              if (errorText != null) Text(errorText!),
            ],
          ),
        ),
      ),
    );
  }
}
