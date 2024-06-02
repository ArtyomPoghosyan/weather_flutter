import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wheather/widget/current_temp.dart';
import 'package:wheather/widget/days_forecast.dart';
import 'package:wheather/widget/header.dart';
import 'package:wheather/widget/side_bar.dart';
import 'package:wheather/widget/weather_info.dart';

import '../store/common.dart';
import '../utils/helpers.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreen();
}

class _BaseScreen extends State<BaseScreen> {
  CommonStore commonStore = CommonStore();

  @override
  void initState() {
    super.initState();
    Helper.getLocation(true).then((_) => Helper.getWeatherData(context));
  }

  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Header(),
          ],
        ),
        drawer: SideBar(),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              children: [
                FutureBuilder(
                  future: Helper.getWeatherData(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      print('Erroriiiiiik: ${snapshot.error}');
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return Container(
                      color: Color.fromARGB(148, 128, 128, 128),
                      child: Observer(
                        builder: (context) {
                          if (commonStore.weatherList.isNotEmpty) {
                            return Column(
                              children: [
                                CurrentTemp(),
                                WeatherInfo(),
                                DaysForecast(),
                              ],
                            );
                          }
                          return Center(child: Text("No data"));
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
