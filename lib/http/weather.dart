import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Weather> futureAlbum;

  @override
  void initState() {
    WeatherFetch weatherFetch = WeatherFetch();
    super.initState();
    futureAlbum = weatherFetch.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Weather>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.address as String);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class WeatherFetch {
  Future<Weather> fetchAlbum() async {
    var url =
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/beijing?unitGroup=metric&include=days&key=TN948HAPC734XPZZM7F9SM9FG&contentType=json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Weather res =
          Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      print(res);
      return res;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('error');
      throw Exception('Failed to load album');
    }
  }
}

class Weather {
  int? queryCost;
  double? latitude;
  double? longitude;
  String? resolvedAddress;
  String? address;
  String? timezone;
  int? tzoffset;
  List<Days>? days;
  Stations? stations;

  Weather(
      {this.queryCost,
      this.latitude,
      this.longitude,
      this.resolvedAddress,
      this.address,
      this.timezone,
      this.tzoffset,
      this.days,
      this.stations});

  Weather.fromJson(Map<String, dynamic> json) {
    queryCost = json['queryCost'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    resolvedAddress = json['resolvedAddress'];
    address = json['address'];
    timezone = json['timezone'];
    tzoffset = json['tzoffset'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(new Days.fromJson(v));
      });
    }
    stations = json['stations'] != null
        ? new Stations.fromJson(json['stations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queryCost'] = this.queryCost;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['resolvedAddress'] = this.resolvedAddress;
    data['address'] = this.address;
    data['timezone'] = this.timezone;
    data['tzoffset'] = this.tzoffset;
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
    if (this.stations != null) {
      data['stations'] = this.stations!.toJson();
    }
    return data;
  }
}

class Days {
  String? datetime;
  int? datetimeEpoch;
  double? tempmax;
  double? tempmin;
  double? temp;
  double? feelslikemax;
  double? feelslikemin;
  double? feelslike;
  double? dew;
  double? humidity;
  double? precip;
  double? precipprob;
  double? precipcover;
  List<String>? preciptype;
  int? snow;
  int? snowdepth;
  double? windgust;
  double? windspeed;
  double? winddir;
  double? pressure;
  double? cloudcover;
  double? visibility;
  double? solarradiation;
  double? solarenergy;
  int? uvindex;
  int? severerisk;
  String? sunrise;
  int? sunriseEpoch;
  String? sunset;
  int? sunsetEpoch;
  double? moonphase;
  String? conditions;
  String? description;
  String? icon;
  List<String>? stations;
  String? source;

  Days(
      {this.datetime,
      this.datetimeEpoch,
      this.tempmax,
      this.tempmin,
      this.temp,
      this.feelslikemax,
      this.feelslikemin,
      this.feelslike,
      this.dew,
      this.humidity,
      this.precip,
      this.precipprob,
      this.precipcover,
      this.preciptype,
      this.snow,
      this.snowdepth,
      this.windgust,
      this.windspeed,
      this.winddir,
      this.pressure,
      this.cloudcover,
      this.visibility,
      this.solarradiation,
      this.solarenergy,
      this.uvindex,
      this.severerisk,
      this.sunrise,
      this.sunriseEpoch,
      this.sunset,
      this.sunsetEpoch,
      this.moonphase,
      this.conditions,
      this.description,
      this.icon,
      this.stations,
      this.source});

  Days.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    datetimeEpoch = json['datetimeEpoch'];
    tempmax = json['tempmax'];
    tempmin = json['tempmin'];
    temp = json['temp'];
    feelslikemax = json['feelslikemax'];
    feelslikemin = json['feelslikemin'];
    feelslike = json['feelslike'];
    dew = json['dew'];
    humidity = json['humidity'];
    precip = json['precip'];
    precipprob = json['precipprob'];
    precipcover = json['precipcover'];
    preciptype = json['preciptype']?.cast<String>();

    snow = json['snow'];
    snowdepth = json['snowdepth'];
    windgust = json['windgust'];
    windspeed = json['windspeed'];
    winddir = json['winddir'];
    pressure = json['pressure'];
    cloudcover = json['cloudcover'];
    visibility = json['visibility'];
    solarradiation = json['solarradiation'];
    solarenergy = json['solarenergy'];
    uvindex = json['uvindex'];
    severerisk = json['severerisk'];
    sunrise = json['sunrise'];
    sunriseEpoch = json['sunriseEpoch'];
    sunset = json['sunset'];
    sunsetEpoch = json['sunsetEpoch'];
    moonphase = json['moonphase'];
    conditions = json['conditions'];
    description = json['description'];
    icon = json['icon'];
    stations = json['stations']?.cast<String>();
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] = this.datetime;
    data['datetimeEpoch'] = this.datetimeEpoch;
    data['tempmax'] = this.tempmax;
    data['tempmin'] = this.tempmin;
    data['temp'] = this.temp;
    data['feelslikemax'] = this.feelslikemax;
    data['feelslikemin'] = this.feelslikemin;
    data['feelslike'] = this.feelslike;
    data['dew'] = this.dew;
    data['humidity'] = this.humidity;
    data['precip'] = this.precip;
    data['precipprob'] = this.precipprob;
    data['precipcover'] = this.precipcover;
    data['preciptype'] = this.preciptype;
    data['snow'] = this.snow;
    data['snowdepth'] = this.snowdepth;
    data['windgust'] = this.windgust;
    data['windspeed'] = this.windspeed;
    data['winddir'] = this.winddir;
    data['pressure'] = this.pressure;
    data['cloudcover'] = this.cloudcover;
    data['visibility'] = this.visibility;
    data['solarradiation'] = this.solarradiation;
    data['solarenergy'] = this.solarenergy;
    data['uvindex'] = this.uvindex;
    data['severerisk'] = this.severerisk;
    data['sunrise'] = this.sunrise;
    data['sunriseEpoch'] = this.sunriseEpoch;
    data['sunset'] = this.sunset;
    data['sunsetEpoch'] = this.sunsetEpoch;
    data['moonphase'] = this.moonphase;
    data['conditions'] = this.conditions;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['stations'] = this.stations;
    data['source'] = this.source;
    return data;
  }
}

class Stations {
  ZBAA? zBAA;

  Stations({this.zBAA});

  Stations.fromJson(Map<String, dynamic> json) {
    zBAA = json['ZBAA'] != null ? new ZBAA.fromJson(json['ZBAA']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zBAA != null) {
      data['ZBAA'] = this.zBAA!.toJson();
    }
    return data;
  }
}

class ZBAA {
  int? distance;
  double? latitude;
  double? longitude;
  int? useCount;
  String? id;
  String? name;
  int? quality;
  int? contribution;

  ZBAA(
      {this.distance,
      this.latitude,
      this.longitude,
      this.useCount,
      this.id,
      this.name,
      this.quality,
      this.contribution});

  ZBAA.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    useCount = json['useCount'];
    id = json['id'];
    name = json['name'];
    quality = json['quality'];
    contribution = json['contribution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['useCount'] = this.useCount;
    data['id'] = this.id;
    data['name'] = this.name;
    data['quality'] = this.quality;
    data['contribution'] = this.contribution;
    return data;
  }
}
