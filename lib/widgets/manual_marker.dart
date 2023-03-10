import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [

            Center(
              child: Transform.translate(
                offset: const Offset(0, -22),
                child: BounceInDown(
                  from: 100,
                  child: Icon( Icons.location_on_rounded, size: 60)
                  ),
              ),
            )

        ],
      ),
      
    );
  }
}