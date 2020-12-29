import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:provider/provider.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 90,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'assets/images/SadFace.png',
                ),
              ),
              Text(
                '"Oh-Uh"',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              Text(
                'Sorry, could not find any account!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Please, add your account',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
          MyBtn(
            title: 'Log In',
            swapActive: true,
            toggleSwap: () async {
              print('pressed log in');
              await Provider.of<AuthServices>(context, listen: false)
                  .googleSignIn();
            },
          ),
        ],
      ),
    );
  }
}
