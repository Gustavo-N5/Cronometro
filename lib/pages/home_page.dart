import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int second = 0, minute = 0, hours = 0;
  String digitSeconds = '00', digitMinutes = '00', digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer?.cancel();

    setState(() {
      started = false;
    });
  }

  void restart() {
    timer?.cancel();
    setState(() {
      second = 0;
      minute = 0;
      hours = 0;

      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';

      started = false;
    });
  }

  void addLaps() {
    String lap = '$digitHours:$digitMinutes:$digitSeconds';

    setState(
      () {
        laps.add(lap);
      },
    );
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = second + 1;
      int localMinutes = minute;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        second = localSeconds;
        minute = localMinutes;
        hours = localHours;

        digitSeconds = (second >= 10) ? "$second" : "0$second";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minute >= 10) ? "$minute" : "0$minute";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: const Text(
                  'Cronometro',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  '$digitHours:$digitMinutes:$digitSeconds',
                  style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nº ${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${laps[index]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        (!started) ? 'Start' : 'Pouse',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      addLaps();
                    },
                    icon: Icon(
                      Icons.flag,
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        restart();
                      },
                      fillColor: Colors.blue,
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        'Restart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
