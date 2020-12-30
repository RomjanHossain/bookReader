import 'package:flutter/material.dart';

class RadioListButtonLOL extends StatefulWidget {
//  RadioListButtonLOL({this.});

  @override
  _RadioListButtonLOLState createState() => _RadioListButtonLOLState();
}

class _RadioListButtonLOLState extends State<RadioListButtonLOL> {
  bool _isActive = false;
  @override
  Widget build(BuildContext context) {
    // return SwitchListTile(
    //   title: Text('add order contains as GIFT'),
    //   value: _isActive,
    //   onChanged: (bool v) {
    //     setState(() => _isActive = v);
    //   },
    // );
    return CheckboxListTile(
        title: Text('add order contains as GIFT'),
        activeColor: Colors.green,
        value: _isActive,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool v) {
          setState(() {
            _isActive = v;
          });
        });
    // return SwitchListTile.adaptive(
    //     value: _isActive,
    //     onChanged: (bool v) {
    //       setState(() {
    //         _isActive = v;
    //       });
    //     });
    // return RadioListTile(
    //     title: Text('fukc yourself'),
    //     value: _isActive,
    //     groupValue: _isActive,
    //     onChanged: (bool v) {
    //       setState(() => _isActive = v);
    //     });
  }
}
