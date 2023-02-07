// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lucky_wheel/provider/user_data.dart';
import 'package:provider/provider.dart';

class Spinner extends StatefulWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  StreamController<int> selected = StreamController<int>();
  var amount;
  @override
  void initState() {
    amount = Provider.of<UserData>(context, listen: false).userbalance;
    super.initState();
  }

  var perSpin = 30;

  void onCall() {
    if (amount >= perSpin) {
      amount = amount - perSpin;
      Provider.of<UserData>(context, listen: false).userbalance = amount;
      Provider.of<UserData>(context, listen: false)
          .sendAmount('Sufyan', amount);
      setState(() {
        selected.add(
          Fortune.randomInt(0, 6),
        );
        print('Your remaining Amount $amount');
      });
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Your dont have money'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      var height = constraint.maxHeight / 2;
      var width = constraint.maxWidth / 2;
      return Stack(
        children: [
          FortuneWheel(
            selected: selected.stream,
            animateFirst: false,
            items: [
              FortuneItem(
                child: Text('1'),
                style: FortuneItemStyle(
                  color: Colors.purple,
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              FortuneItem(
                child: Text('2'),
                style: FortuneItemStyle(
                  color: Color(0xB91584),
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('3'),
                style: FortuneItemStyle(
                  color: Colors.purple,
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('4'),
                style: FortuneItemStyle(
                  color: Color(0xB91584),
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('5'),
                style: FortuneItemStyle(
                  color: Colors.purple,
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('6'),
                style: FortuneItemStyle(
                  color: Color(0xB91584),
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('7'),
                style: FortuneItemStyle(
                  color: Colors.purple,
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('8'),
                style: FortuneItemStyle(
                  color: Color(0xB91584),
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('9'),
                style: FortuneItemStyle(
                  color: Colors.purple,
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('10'),
                style: FortuneItemStyle(
                  color: Color(0xB91584),
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('11'),
                style: FortuneItemStyle(
                  color: Colors.purple,
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FortuneItem(
                child: Text('12'),
                style: FortuneItemStyle(
                  color: Color(0xB91584),
                  borderColor: Colors.white,
                  borderWidth: 5,
                  textStyle: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
            onAnimationEnd: () {
              print('value is $selected');
            },
            physics: CircularPanPhysics(
              duration: Duration(seconds: 1),
              curve: Curves.decelerate,
            ),
            onFling: onCall,
            styleStrategy: UniformStyleStrategy(
              borderColor: Colors.black,
              borderWidth: 5,
            ),
          ),
          Positioned(
            left: width - 30,
            top: height - 30,
            child: GestureDetector(
              onTap: onCall,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    'Spin',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  radius: 30,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
