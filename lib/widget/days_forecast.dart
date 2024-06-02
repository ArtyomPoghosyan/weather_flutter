import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheather/store/common.dart';
import '../utils/constant.dart';

class DaysForecast extends StatefulWidget {
  const DaysForecast({Key? key}) : super(key: key);

  @override
  State<DaysForecast> createState() => _DaysForecast();
}

class _DaysForecast extends State<DaysForecast> {
  CommonStore commonStore = CommonStore();
  late Map<String, Map<String, List<dynamic>>> weekdaysMap;

  @override
  void initState() {
    super.initState();
    weekdaysMap = Constant.weekdaysMap;
    handleWeekDays();
  }

  void handleWeekDays() {
    List<String> weatherList = [];
    List<dynamic> forecastWeather = commonStore.weatherList;
    for (var i = 0; i < forecastWeather.length; i++) {
      dynamic week = DateFormat.EEEE()
          .format(DateTime.parse(forecastWeather[i]['dt_txt']));
      dynamic temp = forecastWeather[i]['main']['temp'];
      dynamic humidity = forecastWeather[i]['main']['humidity'];
      dynamic feels = forecastWeather[i]['main']['feels_like'];
      dynamic min = forecastWeather[i]['main']['temp_min'];
      dynamic max = forecastWeather[i]['main']['temp_max'];
      dynamic pressure = forecastWeather[i]['main']['pressure'];
      dynamic speed = forecastWeather[i]['wind']['speed'];
      String weather = forecastWeather[i]['weather'][0]['main'];
      dynamic clouds = forecastWeather[i]['clouds']['all'];
      dynamic degree = forecastWeather[i]['wind']['deg'];
      // weatherList.add(weather);
      // print("weatheeeeeer${weatherList}");
      switch (week) {
        case "Monday":
        case "Tuesday":
        case "Wednesday":
        case "Thursday":
        case "Friday":
        case "Saturday":
        case "Sunday":
          weekdaysMap[week]!["temperature"]!.add(temp.toDouble());
          weekdaysMap[week]!["humidity"]!.add(humidity.toDouble());
          weekdaysMap[week]!["min"]!.add(min.toDouble());
          weekdaysMap[week]!["max"]!.add(max.toDouble());
          weekdaysMap[week]!["pressure"]!.add(pressure.toDouble());
          weekdaysMap[week]!["feels"]!.add(feels.toDouble());
          weekdaysMap[week]!['deg']!.add(degree);
          weekdaysMap[week]!["weather"]!.add(weather);
          weekdaysMap[week]!["clouds"]!.add(clouds.toDouble());
          weekdaysMap[week]!["speed"]!.add(speed.toDouble());
          break;
        default:
          break;
      }
    }
    weekdaysMap.forEach((key, value) {
      List<dynamic> temps = value['temperature']!;
      List<dynamic> humidities = value['humidity']!;
      List<dynamic> feels = value['feels']!;
      List<dynamic> min = value['min']!;
      List<dynamic> max = value['max']!;
      List<dynamic> pressure = value['pressure']!;
      List<dynamic> degree = value['deg']!;
      List<dynamic> weather = value['weather']!.cast();
      List<dynamic> clouds = value['clouds']!;
      List<dynamic> speed = value['speed']!;
      double avgTemp =
          temps.isNotEmpty ? temps.reduce((a, b) => a + b) / speed.length : 0;
      double avgClouds = clouds.isNotEmpty
          ? clouds.reduce((a, b) => a + b) / clouds.length
          : 0;
      dynamic avgDegree = degree.isNotEmpty
          ? degree.reduce((a, b) => a + b) / degree.length
          : 0;
      Set<dynamic> uniqueWeather = weather.toSet();
      double avgSpeed =
          speed.isNotEmpty ? speed.reduce((a, b) => a + b) / speed.length : 0;
      double avgFeels =
          feels.isNotEmpty ? feels.reduce((a, b) => a + b) / feels.length : 0;
      double avgMin = min.isNotEmpty
          ? min.reduce((value, element) => value < element ? value : element)
          : 0;
      double avgMax = max.isNotEmpty
          ? max.reduce((value, element) => value > element ? value : element)
          : 0;
      double avgPressure = pressure.isNotEmpty
          ? pressure.reduce((a, b) => a + b) / pressure.length
          : 0;
      double avgHumidity = humidities.isNotEmpty
          ? humidities.reduce((a, b) => a + b) / humidities.length
          : 0;
      value['temperature'] = [avgTemp];
      value['humidity'] = [avgHumidity];
      value['feels'] = [avgFeels];
      value['min'] = [avgMin];
      value['max'] = [avgMax];
      value['pressure'] = [avgPressure];
      value['clouds'] = [avgClouds];
      value['speed'] = [avgSpeed];
      value["weather"] = [uniqueWeather];
      value['deg'] = [avgDegree];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(132, 182, 182, 182),
          height: MediaQuery.of(context).size.height * 0.377,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weekdaysMap.length - 1,
            itemBuilder: (context, index) {
              String day = DateFormat.EEEE()
                  .format(DateTime.now().add(Duration(days: index)));
              // print(weekdaysMap[day]!['feels']![0]);
              // print(weekdaysMap[day]!['deg']![0].round());
              return Container(
                width: 200,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        day == Constant.today
                            ? Text(
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                "Today")
                            : Text(
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                day),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.thermostat,
                              size: 14,
                              color: Colors.red,
                            ),
                            Text((weekdaysMap[day]!['temperature']![0]) != 0
                                ? ' ${weekdaysMap[day]!['temperature']![0].round()}°'
                                : "0"),
                            SizedBox(
                              width: 10,
                            ),
                            Transform.rotate(
                                angle: weekdaysMap[day]!['deg']![0].toDouble(),
                                child: Image.asset(
                                  "images/arrow.png",
                                ))
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(style: TextStyle(fontSize: 12), "Feels like"),
                            Text(weekdaysMap[day]!['feels']![0] != 0
                                ? ' ${weekdaysMap[day]!['feels']![0].round()}'
                                : "0"),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.thermostat,
                                  size: 16,
                                  color: Color.fromARGB(255, 170, 212, 247),
                                ),
                                Text(weekdaysMap[day]!['min']![0]
                                        .toString()
                                        .isNotEmpty
                                    ? ' ${weekdaysMap[day]!['min']![0].round()}° - '
                                    : "0"),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.thermostat,
                                  size: 14,
                                  color: Colors.red,
                                ),
                                Text(weekdaysMap[day]!['max']![0]
                                        .toString()
                                        .isNotEmpty
                                    ? ' ${weekdaysMap[day]!['max']![0].round()}°'
                                    : "0"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.water_drop_outlined,
                              color: Colors.blue.shade200,
                              size: 20,
                            ),
                            Text(weekdaysMap[day]!['humidity']![0] != 0
                                ? ' ${weekdaysMap[day]!['humidity']![0].round()} %'
                                : "0"),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(style: TextStyle(fontSize: 12), "Pressure"),
                            Text(weekdaysMap[day]!['pressure']![0]
                                    .toString()
                                    .isNotEmpty
                                ? ' ${weekdaysMap[day]!['pressure']![0].round()}'
                                : "0"),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.cloud_sync_sharp),
                            Text(weekdaysMap[day]!['clouds']![0]
                                    .toString()
                                    .isNotEmpty
                                ? ' ${weekdaysMap[day]!['clouds']![0].round()} %'
                                : "0"),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text.rich(TextSpan(children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.wind_power,
                                  color: Colors.blue.shade200,
                                ),
                              ),
                              TextSpan(
                                  text: weekdaysMap[day]!['speed']![0]
                                          .toString()
                                          .isNotEmpty
                                      ? '${double.parse(weekdaysMap[day]!['speed']![0].toStringAsFixed(1))} m/s'
                                      : "0")
                            ])),
                          ],
                        ),
                        SizedBox(height: 5),
                        SafeArea(
                            child: SingleChildScrollView(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (weekdaysMap[day] != null &&
                                    weekdaysMap[day]!['weather'] != null &&
                                    weekdaysMap[day]!['weather']
                                        .toString()
                                        .isNotEmpty &&
                                    weekdaysMap[day]!['weather']![0]
                                        .contains("Rain"))
                                  Icon(
                                    Icons.cloudy_snowing,
                                  ),
                                if (weekdaysMap[day] != null &&
                                    weekdaysMap[day]!['weather'] != null &&
                                    weekdaysMap[day]!['weather']
                                        .toString()
                                        .isNotEmpty &&
                                    weekdaysMap[day]!['weather']![0]
                                        .contains("Clouds"))
                                  Icon(Icons.cloud,
                                      color: const Color.fromARGB(
                                          255, 15, 139, 240)),
                                if (weekdaysMap[day] != null &&
                                    weekdaysMap[day]!['weather'] != null &&
                                    weekdaysMap[day]!['weather']
                                        .toString()
                                        .isNotEmpty &&
                                    weekdaysMap[day]!['weather']![0]
                                        .contains("Clear"))
                                  Icon(
                                    Icons.sunny,
                                    color: Colors.yellow,
                                  ),
                                if (weekdaysMap[day] != null &&
                                    weekdaysMap[day]!['weather'] != null &&
                                    weekdaysMap[day]!['weather']
                                        .toString()
                                        .isNotEmpty &&
                                    weekdaysMap[day]!['weather']![0]
                                        .contains("Snow"))
                                  Container(
                                    height: 30,
                                    child: Stack(children: [
                                      Icon(Icons.cloud),
                                      Positioned(
                                          top: 10,
                                          child: Icon(
                                            Icons.snowing,
                                            color: Colors.white,
                                          ))
                                    ]),
                                  )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
