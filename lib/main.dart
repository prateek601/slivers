import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slivers/services.dart';
import 'package:slivers/weekly_forecast_list.dart';

void main() {
  runApp(const HorizonsApp());
}

class HorizonsApp extends StatelessWidget {
  const HorizonsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // This is the theme of your application.
      theme: ThemeData.dark(),
      // Scrolling in Flutter behaves differently depending on the
      // ScrollBehavior. By default, ScrollBehavior changes depending
      // on the current platform. For the purposes of this scrolling
      // workshop, we're using a custom ScrollBehavior so that the
      // experience is the same for everyone - regardless of the
      // platform they are using.
      scrollBehavior: const ConstantScrollBehavior(),
      title: 'Horizons Weather',
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              stretch: true,
              expandedHeight: 200,
              backgroundColor: Colors.teal[800]!,
              onStretchTrigger: () async {
                log('Load new data!');
                // await Server.requestNewData();
              },
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Horizons'),
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: <Color>[
                        Colors.teal[800]!,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Image.network(
                    headerImage,
                    fit: BoxFit.cover,
                  ),
                ),
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(height: 300, color: Colors.grey),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Weather forecast',
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Watch',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.tealAccent),
                        ),
                        Text(
                          'See all',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.tealAccent),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 30),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const Card(
                    color: Colors.green,
                    elevation: 5,
                  ),
                  childCount: 6,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ),
            const WeeklyForecastList()
          ],
        ),
      ),
    );
  }
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.android;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
