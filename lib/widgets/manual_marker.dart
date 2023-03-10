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

            const Positioned(
              top: 70,
              left: 20,
              child: _BtnBack()
              ),


            Center(
              child: Transform.translate(
                offset: const Offset(0, -22),
                child: BounceInDown(
                  from: 100,
                  child: Icon( Icons.location_on_rounded, size: 60)
                  ),
              ),
            ),

            //boton de confirmar
            Positioned(
              bottom: 70,
              left: 40,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                  minWidth: size.width -120,
                  child: const Text('Confirm Destination', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                  color: Colors.black, 
                  elevation: 0,
                  height: 50,
                  shape: const StadiumBorder(),
                  onPressed: (){
              
                  },
                ),
              )
            ),

        ],
      ),
      
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon( Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: (){
            //TODO: cancelar el marcador manual
          },
        ),
      ),
    );
  }
}