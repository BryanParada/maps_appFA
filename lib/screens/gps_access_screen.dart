import 'package:flutter/material.dart';

class GpsAccessScreen extends StatelessWidget {
   
  const GpsAccessScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: _AccessButton(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const Text('GPS Access is required'),
         MaterialButton(
          child: const Text('Grant Access', style: TextStyle(color: Colors.white)),
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: (){}
          )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return const Text('Yo must enable GPS',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300));
  }
}