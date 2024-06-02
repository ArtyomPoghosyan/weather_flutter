import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../service/index.dart';

part 'common.g.dart';

class CommonStore extends TCommonStore {
  static final CommonStore _singleton = CommonStore._internal();
  factory CommonStore() {
    return _singleton;
  }
  CommonStore._internal();
}

class TCommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {
  @observable
  late ObservableList weatherList = ObservableList();

  @observable
  late ObservableList currentDayWeathe = ObservableList();

  @observable
  late dynamic currentTemp = 0;

  @observable
  late dynamic cityName = "";

  @observable
  late dynamic currentLocationPlace = ObservableSet();

  @action
  void setWeatherData(List value) {
    weatherList = value.asObservable();
  }

  @action
  void setCurrentWeather(List value) {
    currentDayWeathe = value.asObservable();
  }

  @action
  void setTemp(value) {
    currentTemp = value;
  }

  @action
  void setCityName(value) {
    cityName = value;
  }

  @action
  void setCurrentLocationPlace(String value) {
    currentLocationPlace = value;
  }
}
