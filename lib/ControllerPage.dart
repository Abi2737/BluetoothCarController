import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RotatedBox(
                quarterTurns: 3,
                child: Slider(
                  min: -255,
                  max: 255,
                  value: _upDownValue,
                  onChanged: onUpDownValueChanged,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Slider(
                min: -255,
                max: 255,
                value: _leftRightValue,
                onChanged: onLeftRightValueChange,
              ),
            ],
          ),
        ],
      ),
    );
  }


  void onLeftRightValueChange(double value) {
    setState(() {
      _leftRightValue = value;

      print("lr: $_leftRightValue");
    });
  }

  void onUpDownValueChanged(double value) {
    _upDownValue = value;
    print("ud: $_upDownValue");

    setState(() {});
  }
}
