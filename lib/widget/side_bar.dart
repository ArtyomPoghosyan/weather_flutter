import 'package:flutter/material.dart';
import 'package:wheather/utils/constant.dart';

import '../store/common.dart';
import 'radar.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBar();
}

class _SideBar extends State<SideBar> {
  CommonStore commonStore = CommonStore();
  @override
  Widget build(BuildContext context) => Drawer(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Constant.currentHour < 18
                          ? AssetImage("images/sky.jpg")
                          : AssetImage("images/sky.jpg"),
                      fit: BoxFit.cover)),
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 0, 25),
                child: buildHeader(context),
              ),
            ),
            buildMenuItems(context)
          ],
        )),
      );

  Widget buildHeader(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: commonStore.cityName.toString().isNotEmpty
                  ? Text('${commonStore.cityName}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                  : Text('${commonStore.currentLocationPlace}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    '${commonStore.currentTemp}°'),
              ],
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        child: Column(
          children: [
            ListTile(
                leading: const Icon(Icons.device_thermostat_rounded),
                title: const Text("Temperature radar"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MapSample(MapType: "TA2")));
                }),
            ListTile(
                leading: const Icon(Icons.cloud_sync_outlined),
                title: const Text("Clouds radar"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MapSample(MapType: "CL")));
                }),
            ListTile(
                leading: const Icon(Icons.snowing),
                title: const Text("Rain radar"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MapSample(MapType: "PR0")));
                }),
            ListTile(
                leading: const Icon(Icons.cloudy_snowing),
                title: const Text("Snow radar"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MapSample(MapType: "PAS0")));
                }),
            ListTile(
                leading: const Icon(Icons.wind_power_outlined),
                title: const Text("Wind radar"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MapSample(MapType: "WND")));
                }),
          ],
        ),
      );
}
