import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/common.dart';

class CurrentTemp extends StatefulWidget {
  CurrentTemp({Key? key}) : super(key: key);

  @override
  State<CurrentTemp> createState() => _CurrentTemp();
}

class _CurrentTemp extends State<CurrentTemp> {
  CommonStore commonStore = CommonStore();
  final List todayList = [];
  final DateTime today = DateTime.now();
  var currentTempInfo = [];

  @override
  void initState() {
    super.initState();
    compareDays();
  }

  void compareDays() {
    if (commonStore.weatherList.isNotEmpty) {
      final filteredDay = commonStore.weatherList.where((element) =>
          DateTime.parse(element['dt_txt'].toString()).day ==
          DateTime.parse(today.toString()).day);
      setState(() {
        todayList.add(filteredDay);
        commonStore.setCurrentWeather([filteredDay]);
        showTimeTemp();
      });
    }
  }

  void showTimeTemp() {
    final currentHour = DateTime.parse(today.toString()).hour;
    todayList.forEach((element) {
      for (var key in element) {
        final currentDayHours = DateTime.parse(key['dt_txt'].toString()).hour;
        if (currentHour + 1 == currentDayHours) {
          // print("++++++++${currentDayHours}");
          setState(() {
            currentTempInfo.add(key);
          });
        } else if (currentHour - 1 == currentDayHours) {
          // print("------------${currentDayHours}");
          // print(currentDayHours);
          setState(() {
            // print("ooooooookkkkkkkkkk${currentDayHours}");
            currentTempInfo.add(key);
          });
        } else {
          // print(currentDayHours);
          setState(() {
            currentTempInfo.add(key);
          });
        }
        commonStore.setTemp(key['main']['temp'].round());
        return;
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      height: 190,
      child: Observer(builder: (context) {
        return ListView.builder(
            itemCount: currentTempInfo.length,
            itemBuilder: (context, index) {
              if (currentTempInfo.isEmpty) {
                return Center(
                  child: Text("IS Empty"),
                );
              } else {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                          child: Observer(
                            builder: (context) {
                              if (commonStore.cityName.isNotEmpty) {
                                return Text(
                                  '${commonStore.cityName}',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                );
                              } else {
                                return Text(
                                  '${commonStore.currentLocationPlace}',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                          child: Center(
                            child: Center(
                              child: currentTempInfo.isNotEmpty
                                  ? currentTempInfo[index]['weather'][0]
                                              ['main'] ==
                                          "Clear"
                                      ? Container(
                                          child: Icon(
                                            Icons.sunny,
                                            size: 80,
                                            color: Colors.yellow,
                                          ),
                                        )
                                      : currentTempInfo[index]['weather'][0]
                                                  ['main'] ==
                                              "Rain"
                                          ? Icon(
                                              Icons.cloudy_snowing,
                                              size: 80,
                                            )
                                          : currentTempInfo[index]['weather'][0]
                                                      ['main'] ==
                                                  "Clouds"
                                              ? Icon(
                                                  Icons.cloud,
                                                  size: 80,
                                                )
                                              : Icon(Icons.snowing,
                                                  color: Colors.white)
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                          itemCount: currentTempInfo.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Container(
                                width: 150,
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                '${currentTempInfo[index]['main']['temp'].round()}°'),
                                          ],
                                        ),
                                        Text(
                                            style: TextStyle(fontSize: 12),
                                            ' Feels like ${currentTempInfo[index]['main']['feels_like'].round()}°'),
                                        Text(
                                            style: TextStyle(fontSize: 12),
                                            ' Humidity ${currentTempInfo[index]['main']['humidity']} %')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // trailing: Container(
                              //   child: currentTempInfo[index]['main']['temp']
                              //               .round() >
                              //           0
                              //       ? Container(
                              //           child: Icon(
                              //             Icons.device_thermostat_rounded,
                              //             size: 26,
                              //             color: Colors.red,
                              //           ),
                              //         )
                              //       : Icon(
                              //           Icons.device_thermostat_rounded,
                              //           size: 26,
                              //           color: Colors.blue,
                              //         ),
                              // ),
                            );
                          }),
                    )
                  ],
                );
              }
            });
      }),
    );
  }
}
