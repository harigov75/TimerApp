// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const CountDownTimer());
}

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);
  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer timer;

  TextEditingController secondControl = TextEditingController();
  TextEditingController minuteControl = TextEditingController();
  TextEditingController hourControl = TextEditingController();
  //bool checkState = false;
  int hour = 00;
  int minute = 00;
  int second = 00;
  bool checker = false;

  void startTimer() {
    if (checker) return;
    checker = true;

    setState(() {
      hour = int.tryParse(hourControl.text) ?? 0;
      minute = int.tryParse(minuteControl.text) ?? 0;
      second = int.tryParse(secondControl.text) ?? 0;
    });
    int totalSeconds = hour * 3600 + minute * 60 + second;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
          hour = totalSeconds ~/ 3600;
          minute = (totalSeconds % 3600) ~/ 60;
          second = totalSeconds % 60;
        } else {
          timer.cancel();
          checker = false;
          resetTimer();
        }
      });
    });
  }

  void resetTimer() {
    timer.cancel();
    setState(() {
      second = 0;
      minute = 0;
      hour = 0;
      checker = false;
      hourControl.text = "";
      minuteControl.text = "";
      secondControl.text = "";
    });
  }

  Color color1 = Color(0xff0d1b2a);
  Color color2 = Color(0xff1b263b);
  Color colorText = Color(0xffe0e1dd);
  Color colorButton = Color(0xff415a77);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 97, 11, 112),
        //   title: const Text("Count Down",
        //       style: TextStyle(color: Color.fromARGB(255, 255, 235, 54))),
        // ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color1, color2])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    "Timer",
                    style: TextStyle(
                        color: colorText,
                        fontSize: 50,
                        fontFamily: 'NotoSans-Bold'),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "$hour:$minute:$second",
                    style: TextStyle(
                        color: colorText,
                        fontSize: 100,
                        fontFamily: 'NotoSans-Black'),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    //hours
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: colorText),
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        controller: hourControl,
                        onChanged: (v) => hourControl.text = v,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: colorText)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorText)),
                          label: Center(
                            child: Text(
                              "Hours",
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: colorText,
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ), //minutes
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: colorText),
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        controller: minuteControl,
                        textAlign: TextAlign.center,
                        onChanged: (v) => minuteControl.text = v,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: colorText)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorText)),
                            label: Center(
                              child: Text(
                                "Minutes",
                                style: TextStyle(fontFamily: 'NotoSans-Light'),
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: colorText,
                            ),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    //seconds

                    Expanded(
                      child: TextField(
                        style: TextStyle(color: colorText),
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        controller: secondControl,
                        onChanged: (v) => secondControl.text = v,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: colorText)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorText)),
                            label: Center(
                              child: Text(
                                "Seconds",
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: colorText,
                            ),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: colorButton),
                        onPressed: () {
                          startTimer();
                        },
                        child: Text(
                          "START",
                          style: TextStyle(color: colorText),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Center(
                      child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: colorButton),
                        onPressed: () {
                          resetTimer();
                        },
                        child: Text(
                          "RESET",
                          style: TextStyle(color: colorText),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
