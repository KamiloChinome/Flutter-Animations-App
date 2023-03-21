import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimationScreen extends StatefulWidget {
  
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin{
  late Animation<double> rotation;
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.bounceOut)
    );
    opacity =Tween(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.60, 1, curve: Curves.easeOut))
    );
    controller.addListener(() { 
      print('Status: ${controller.status}');
      if(controller.status == AnimationStatus.completed){
        controller.reset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      // child: child,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: rotation.value,
          child: Opacity(
            opacity: opacity.value,
            child: const _Rectangulo())
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  const _Rectangulo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        width: 70,
        decoration: const BoxDecoration(
          color: Colors.blue
        ),    
      ),
    );
  }
}