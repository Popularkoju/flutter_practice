import 'package:flutter/material.dart';

class ScrollProgress extends StatefulWidget {
  const ScrollProgress({super.key});

  @override
  State<ScrollProgress> createState() => _ScrollProgressState();
}

class _ScrollProgressState extends State<ScrollProgress> {
  ScrollController controller = ScrollController();
  int index = 0;
  double circularValue = 0.0;

  @override
  void initState() {
    controller.addListener(() {
      index = controller.position.pixels ~/ 100;
      circularValue = controller.position.pixels / 0.00001;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
             SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                value: circularValue,
                valueColor: AlwaysStoppedAnimation(Colors.cyan),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  controller: controller,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.red,
                        width: 100,
                        height: 100,
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
