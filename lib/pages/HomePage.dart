import 'dart:async';

import 'package:carcontroller/pages/ControllerPage.dart';
import 'package:carcontroller/utils/BluetoothCommunication.dart';
import 'package:carcontroller/widgets/BluetoothCommunicationStatusWidget.dart';
import 'package:carcontroller/widgets/BluetoothStatusWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'CommunicationPage.dart';
import 'FindDevicesPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCommunicationReady = false;
  BluetoothState _bluetoothState = BluetoothState.unknown;
  List<StreamSubscription> _streamSubscriptions = List();

  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(
      FlutterBlue.instance.state.listen(
        (newState) {
          if (newState != _bluetoothState) {
            _bluetoothState = newState;
            _refresh();
          }
        },
      ),
    );

    _streamSubscriptions.add(
      BluetoothCommunication.instance.onNewDevice.listen((_) => _refresh()),
    );

    _streamSubscriptions.add(
      BluetoothCommunication.instance.isReady.listen(
        (isReady) {
          if (isReady != _isCommunicationReady) {
            _isCommunicationReady = isReady;
            _refresh();
          }
        },
      ),
    );
  }

  void _refresh() {
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BluetoothStatusWidget(state: _bluetoothState),
            BluetoothCommunicationStatusWidget(bluetoothState: _bluetoothState),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Find devices'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: _bluetoothState != BluetoothState.on
                          ? null
                          : () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FindDevicesPage()));
                            },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: const Text('Communication Page'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: !_isCommunicationReady
                          ? null
                          : () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CommunicationPage()));
                            },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: const Text('Controller'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: !_isCommunicationReady
                          ? null
                          : () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ControllerPage()));
                            },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _streamSubscriptions.forEach((subscription) => subscription.cancel());
  }
}
