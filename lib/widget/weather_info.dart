import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheather/utils/constant.dart';

import '../store/common.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({super.key});

  @override
  State<WeatherInfo> createState() => _WeatherInfo();
}

class _WeatherInfo extends State<WeatherInfo> {
  CommonStore commonStore = CommonStore();
  bool isShow = false;
  int currentIndex = 0;
  List arr = [];

  @override
  Widget build(BuildContext context) {
    List currentDayInfo = commonStore.currentDayWeathe;

    return Container(
      child: Column(
        children: [
          Container(
            height: 190,
            child: ListView.builder(
                itemCount: currentDayInfo.length,
                itemBuilder: (context, index) {
                  arr = currentDayInfo[index].toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Today",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 174,
                        child: ListView.builder(
                          scrollDirection:
                              arr.length < 2 ? Axis.vertical : Axis.horizontal,
                          itemCount: arr.length,
                          itemBuilder: (context, index) {
                            // print(arr[index]['wind']['deg'].round().runtimeType);

                            return Container(
                              color: const Color.fromARGB(174, 212, 211, 211),
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: Text.rich(TextSpan(children: [
                                      TextSpan(
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        text: DateFormat.Hm().format(
                                            DateTime.parse(
                                                arr[index]['dt_txt'])),
                                      ),
                                    ])),
                                    subtitle: Row(
                                      children: [
                                        const Icon(
                                          Icons.thermostat,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                        Text(
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                            '${arr[index]['main']['temp'].round()}°'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Transform.rotate(
                                            angle: arr[index]['wind']['deg']
                                                .toDouble(),
                                            child: Image.asset(
                                              "images/arrow.png",
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Feels like: ${arr[index]['main']['feels_like'].round()}°"),
                                            Text.rich(TextSpan(children: [
                                              const WidgetSpan(
                                                  child: Icon(
                                                Icons.water_drop_outlined,
                                                color: Colors.blue,
                                                size: 20,
                                              )),
                                              TextSpan(
                                                  text:
                                                      " ${arr[index]['main']['humidity']} %")
                                            ])),
                                            // Text(
                                            //     "Pressure: ${arr[index]['main']['pressure']} hPa"),
                                            // Text(
                                            //     "Desc: ${arr[index]['weather'][0]['description']}"),
                                            Text.rich(TextSpan(children: [
                                              const WidgetSpan(
                                                child: Icon(
                                                  Icons.wind_power,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              TextSpan(
                                                  text:
                                                      ' ${arr[index]['wind']['speed']} m/s'),
                                            ])),
                                          ],
                                        ),
                                        SizedBox(width: 10),
                                        arr[index]['weather'][0]['main'] ==
                                                    "Clouds" &&
                                                arr[index]['clouds']['all'] < 70
                                            ? Container(
                                                width: 60,
                                                child: const Stack(
                                                  children: [
                                                    Icon(
                                                      Icons.cloud,
                                                      size: 30,
                                                      color: Color.fromARGB(
                                                          255, 15, 139, 240),
                                                    ),
                                                    Positioned(
                                                        left: 20,
                                                        child: Icon(
                                                          Icons.sunny,
                                                          color: Colors.yellow,
                                                        ))
                                                  ],
                                                ),
                                              )
                                            : arr[index]['weather'][0]
                                                        ['main'] ==
                                                    "Clouds"
                                                ? Container(
                                                    width: 60,
                                                    child: const Stack(
                                                      children: [
                                                        Icon(
                                                          Icons.cloud,
                                                          size: 30,
                                                          color: Color.fromARGB(
                                                              255,
                                                              15,
                                                              139,
                                                              240),
                                                        ),
                                                        Positioned(
                                                            left: 20,
                                                            child: Icon(
                                                              Icons.sunny,
                                                              color:
                                                                  Colors.yellow,
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                : arr[index]['weather'][0]
                                                            ['main'] ==
                                                        "Rain"
                                                    ? const Icon(
                                                        Icons.cloudy_snowing,
                                                      )
                                                    : arr[index]['weather'][0]
                                                                ['main'] ==
                                                            "Snow"
                                                        ? const Icon(
                                                            Icons
                                                                .cloudy_snowing,
                                                          )
                                                        : const Icon(
                                                            Icons.sunny,
                                                            color:
                                                                Colors.yellow,
                                                          )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              isShow = !isShow;
                                              currentIndex = index;
                                              // print(arr[currentIndex]['main']
                                              // ['temp_min']);
                                            });
                                          },
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
          ),
          isShow == true
              ? Container(
                  color: Color.fromARGB(144, 245, 233, 233),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 2, 13, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.air,
                                  size: 16,
                                ),
                                Text(
                                    '${arr[currentIndex]['main']['pressure']} hPa'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.thermostat,
                                    size: 16,
                                    color: Color.fromARGB(255, 170, 212, 247)),
                                Text(
                                    "${arr[currentIndex]['main']['temp_min'].round()} -"),
                                Icon(Icons.thermostat,
                                    size: 16, color: Colors.red),
                                Text(
                                    "${arr[currentIndex]['main']['temp_max'].round()}"),
                              ],
                            ),
                            // Text(
                            //     "${arr[currentIndex]['weather']['description']}"),
                            Text(
                                "Description - ${arr[currentIndex]['weather'][0]['description']}"),
                          ],
                        ),
                      ),
                      Column(
                        children: [],
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
