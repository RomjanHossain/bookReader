import 'package:flutter/material.dart';
import 'package:knowyourbook/services/providers/cart.dart';
import 'package:provider/provider.dart';

class RadioListButtonLOL extends StatefulWidget {
  @override
  _RadioListButtonLOLState createState() => _RadioListButtonLOLState();
}

class _RadioListButtonLOLState extends State<RadioListButtonLOL> {
  bool _isActive = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('add order contains as GIFT'),
      activeColor: Colors.green,
      value: _isActive,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool v) {
        setState(() {
          _isActive = v;
          Provider.of<CartModel>(context, listen: false).isGift = _isActive;
        });
      },
    );
  }
}

class RadioListButtonLOL2 extends StatefulWidget {
  @override
  _RadioListButtonLOL2State createState() => _RadioListButtonLOL2State();
}

class _RadioListButtonLOL2State extends State<RadioListButtonLOL> {
  bool _isActive = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text('in Dhaka'),
        activeColor: Colors.blue,
        value: _isActive,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool v) {
          setState(() {
            _isActive = v;
          });
        });
  }
}
