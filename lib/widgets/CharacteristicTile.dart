import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'DescriptorTile.dart';

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;
  final VoidCallback onNotifyPressed;

  const CharacteristicTile({
    Key key,
    this.characteristic,
    this.descriptorTiles,
    this.onReadPressed,
    this.onWritePressed,
    this.onNotifyPressed,
  }) : super(key: key);

  List<Widget> _buildReadWriteNotify(BuildContext context) {
    List<Widget> result = new List();

    // notify characteristic
    result.add(Opacity(
      opacity: characteristic.properties.notify ? 1 : 0,
      child: IconButton(
        icon: Icon(
          characteristic.isNotifying ? Icons.sync_disabled : Icons.sync,
          color: Theme.of(context).iconTheme.color.withOpacity(0.5),
        ),
        onPressed: onNotifyPressed,
      ),
    ));

    // write characteristic
    result.add(Opacity(
      opacity: characteristic.properties.write ? 1 : 0,
      child: IconButton(
        icon: Icon(
          Icons.file_upload,
          color: Theme.of(context).iconTheme.color.withOpacity(0.5),
        ),
        onPressed: onWritePressed,
      ),
    ));

    // read characteristic
    result.add(Opacity(
      opacity: characteristic.properties.read ? 1 : 0,
      child: IconButton(
        icon: Icon(
          Icons.file_download,
          color: Theme.of(context).iconTheme.color.withOpacity(0.5),
        ),
        onPressed: onReadPressed,
      ),
    ));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Characteristic'),
                Text(
                    '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).textTheme.caption.color))
              ],
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(value.toString()),
                Text(String.fromCharCodes(value)),
              ],
            ),
            contentPadding: EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[..._buildReadWriteNotify(context)],
          ),
          children: descriptorTiles,
        );
      },
    );
  }
}
