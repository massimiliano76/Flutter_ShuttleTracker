import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

Widget buildInitialState() {
  return Column(
    children: [
      Flexible(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(42.73, -73.6767),
            zoom: 14,
            maxZoom: 20,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              tileProvider: CachedNetworkTileProvider(),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLoadingState() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildLoadedState(routes, location, stops, updates, mapkey) {
  return Stack(children: <Widget>[
    Column(
      children: [
        Flexible(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(42.73, -73.6767),
              zoom: 14,
              maxZoom: 20,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                tileProvider: CachedNetworkTileProvider(),
              ),
              PolylineLayerOptions(polylines: routes),
              MarkerLayerOptions(markers: location),
              MarkerLayerOptions(markers: stops),
              MarkerLayerOptions(markers: updates),
            ],
          ),
        ),
      ],
    ),
    Positioned(
      height: 50,
      width: 400,
      bottom: 1,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          color: Colors.white,
          child: HtmlWidget(
            """<h5>Map tiles by <a href="http://stamen.com">Stamen Design</a>, under 
                  <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>. Data by 
                  <a href="http://openstreetmap.org">OpenStreetMap</a>, under 
                  <a href="http://www.openstreetmap.org/copyright">ODbL</a>. </h5>""",
            hyperlinkColor: Colors.blue,
          ),
        ),
      ),
    ),
    Positioned(
      height: 100,
      width: 150, //TODO: MAKE THIS VALUE DYNAMICALLY RELATIVE TO LONGEST TEXT WIDGET
      bottom: 50,
      left: 10,
      child: Opacity(
        opacity: 0.95,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.circular(0.5),
            border: Border(bottom: BorderSide(width: 0.5, color: Colors.black)),
          ),
          child: Align(
            child: ListView(
              children: mapkey,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      ),
    )
  ]);
}

Widget buildErrorState(String message) {
  return Center(
    child: Text(message),
  );
}