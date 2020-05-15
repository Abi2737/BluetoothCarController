import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

const double ZERO_MARGIN = 0.2;

class ControllerPage extends StatefulWidget {
  ControllerPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  // A call to setState tells the Flutter framework that something has
  // changed in this State, which causes it to rerun the build method below
  // so that the display can reflect the updated values.

  double _leftRightValue;
  double _upDownValue;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    _leftRightValue = 0;
    _upDownValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Acceleration / Deceleration
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FlutterSlider(
                values: [_upDownValue],
                max: 1,
                min: -1,
                rtl: true,
                step: FlutterSliderStep(step: 0.05),
                centeredOrigin: true,
                axis: Axis.vertical,
                onDragging: onUpDownValueChanged,
                hatchMark: FlutterSliderHatchMark(
                  density: 0.2, // means 20 lines, from 0 to 100 percent
                  displayLines: true,
                  labelsDistanceFromTrackBar: 130,
                  labels: [
                    FlutterSliderHatchMarkLabel(percent: 0, label: Text('Down 100%')),
                    FlutterSliderHatchMarkLabel(percent: 50, label: Text('0')),
                    FlutterSliderHatchMarkLabel(percent: 100, label: Text('Up 100%')),
                  ],
                ),
              ),
            ),
          ),

          // Left / Right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlutterSlider(
                values: [_leftRightValue],
                max: 1.0,
                min: -1.0,
                step: FlutterSliderStep(step: 0.05),
                centeredOrigin: true,
                axis: Axis.horizontal,
                onDragging: onLeftRightValueChange,
                hatchMark: FlutterSliderHatchMark(
                  density: 0.2, // means 20 lines, from 0 to 100 percent
                  displayLines: true,
                  labelsDistanceFromTrackBar: -75,
                  labels: [
                    FlutterSliderHatchMarkLabel(percent: 0, label: Text('Left 100%')),
                    FlutterSliderHatchMarkLabel(percent: 50, label: Text('Straight')),
                    FlutterSliderHatchMarkLabel(percent: 100, label: Text('Right 100%')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  dynamic onLeftRightValueChange(
      int handlerIndex, dynamic lowerValue, dynamic upperValue) {
    _leftRightValue = lowerValue;

    if (_leftRightValue.abs() <= ZERO_MARGIN) {
      print("asdasdasdasd");
      _leftRightValue = 0;
    }

    print("lr: $_leftRightValue");
    setState(() {});
  }

  dynamic onUpDownValueChanged(
      int handlerIndex, dynamic lowerValue, dynamic upperValue) {
    _upDownValue = lowerValue;

    if (_upDownValue.abs() <= ZERO_MARGIN) {
      _upDownValue = 0;
    }

    print("ud: $_upDownValue, $upperValue");

    setState(() {});
  }
}
