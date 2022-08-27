import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slivers/services.dart';

class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, outerIndex) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, innerIndex) {
              log('outer index is: $outerIndex, inner index is: $innerIndex');
              final dailyForecast = Server.getDailyForecastByID(innerIndex);
              return Card(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 130.0,
                      width: 130.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          DecoratedBox(
                            position: DecorationPosition.foreground,
                            decoration: const BoxDecoration(
                              gradient: RadialGradient(
                                colors: <Color>[
                                  Colors.white38,
                                  Colors.transparent
                                ],
                              ),
                            ),
                            child: Image.network(
                              dailyForecast.imageId,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: Text(
                              dailyForecast.getDate(currentDate.day).toString(),
                              style: textTheme.headline2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dailyForecast.getWeekday(currentDate.weekday),
                              style: textTheme.headline4,
                            ),
                            const SizedBox(height: 10.0),
                            Text(dailyForecast.description),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                        style: textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 7,
          );
        },
        childCount: 2,
      ),
    );
  }
}