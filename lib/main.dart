import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

Future<Countries> getCountries() async{
  final response = await http.get("https://restcountries.eu/rest/v2/name/suriname");

  if(response.statusCode == 200){
    List<dynamic> list = json.decode(response.body);
    return Countries.fromJson(list[0]);
  }else{
    throw Exception("Failed to get the country");
  }
}

class Countries {
  String name;
  String capital;
  String region;
  String subRegion;
  int population;
  String flag;
  String nativeName;

  Countries({this.name, this.capital, this.region, this.subRegion, this.population, this.flag, this.nativeName});

  factory Countries.fromJson(Map<String, dynamic> json){
    return Countries(
      name: json['name'],
      capital: json['capital'],
      region: json['region'],
      subRegion: json['subregion'],
      population: json['population'],
      flag: json['flag'],
      nativeName: json['nativeName'],
    );
  }

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Countries'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Countries> futureCountries;

  @override
  void initState(){
    super.initState();
    futureCountries = getCountries();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 300,
                  //color: Colors.black12,
                  child: Column(
                      children: <Widget>[
                        Expanded(
                            child: FutureBuilder<Countries>(
                              future: futureCountries,
                              builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return SvgPicture.network(snapshot.data.flag);
                                  }else if(snapshot.hasError){
                                    return Text("${snapshot.error}");
                                  }

                                  return CircularProgressIndicator();
                                },
                            )
                        ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: FutureBuilder<Countries>(
                                            future: futureCountries,
                                            builder: (context, snapshot){
                                              if(snapshot.hasData){
                                                return Text('Name: ${snapshot.data.name}');
                                              }else if(snapshot.hasError){
                                                return Text("${snapshot.error}");
                                              }

                                              return CircularProgressIndicator();
                                            },
                                          )
                                      ),
                                      Expanded(
                                          child: FutureBuilder<Countries>(
                                            future: futureCountries,
                                            builder: (context, snapshot){
                                              if(snapshot.hasData){
                                                return Text('Native name: ${snapshot.data.nativeName}');
                                              }else if(snapshot.hasError){
                                                return Text("${snapshot.error}");
                                              }

                                              return CircularProgressIndicator();
                                            },
                                          )
                                      ),
                                      Expanded(
                                          child: FutureBuilder<Countries>(
                                            future: futureCountries,
                                            builder: (context, snapshot){
                                              if(snapshot.hasData){
                                                return Text('Capital: ${snapshot.data.capital}');
                                              }else if(snapshot.hasError){
                                                return Text("${snapshot.error}");
                                              }

                                              return CircularProgressIndicator();
                                            },
                                          )
                                      ),
                                    ],
                              )
                            ),
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: FutureBuilder<Countries>(
                                          future: futureCountries,
                                          builder: (context, snapshot){
                                            if(snapshot.hasData){
                                              return Text('Region: ${snapshot.data.region}');
                                            }else if(snapshot.hasError){
                                              return Text("${snapshot.error}");
                                            }

                                            return CircularProgressIndicator();
                                          },
                                        )
                                    ),
                                    Expanded(
                                        child: FutureBuilder<Countries>(
                                          future: futureCountries,
                                          builder: (context, snapshot){
                                            if(snapshot.hasData){
                                              return Text('Sub-region: ${snapshot.data.subRegion}');
                                            }else if(snapshot.hasError){
                                              return Text("${snapshot.error}");
                                            }

                                            return CircularProgressIndicator();
                                          },
                                        )
                                    ),
                                    Expanded(
                                        child: FutureBuilder<Countries>(
                                          future: futureCountries,
                                          builder: (context, snapshot){
                                            if(snapshot.hasData){
                                              return Text('Population: ${snapshot.data.population}');
                                            }else if(snapshot.hasError){
                                              return Text("${snapshot.error}");
                                            }

                                            return CircularProgressIndicator();
                                          },
                                        )
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                    )
                  ),
                  ],
                ),
                ),
              ],
            ),
      ),
    );
  }
}
