import 'package:flutter/material.dart';

class BottomSheetDemo extends StatefulWidget {
  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo>
    with SingleTickerProviderStateMixin {
  double _sheetPosition = 0;
  double _maxSheetPosition = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 3));
    // _animation = Tween<double>(begin: 500, end: 0).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _sheetPosition += details.primaryDelta!;
            if (_sheetPosition < 0) _sheetPosition = 0;
            if (_sheetPosition > _maxSheetPosition) {
              _maxSheetPosition = _sheetPosition;
            }
          });
        },
        onVerticalDragEnd: (details) {
          setState(() {
            if (_sheetPosition > screenHeight / 2) {
              _sheetPosition = screenHeight;
            } else {
              _sheetPosition = 0;
            }
          });
        },
        child: Stack(
          children: [
            Container(
              color: Colors.blueGrey,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // _animation =
                    //     Tween<double>(begin: screenHeight / 2, end:0 )
                    //         .animate(_animationController);
                    // _animationController.reverse();
                    setState(() {
                      _sheetPosition = screenHeight / 2;
                    });
                  },
                  child: const Text(
                    "see",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: _sheetPosition + MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              duration: const Duration(milliseconds: 100),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _sheetPosition = 0;
                  });
                },
                onVerticalDragUpdate: (details) {
                  setState(() {
                    if(_sheetPosition == 0) return;
                    _sheetPosition += details.primaryDelta!;
                    if (_sheetPosition < 0) _sheetPosition = 0;
                    if (_sheetPosition > _maxSheetPosition) {
                      _maxSheetPosition = _sheetPosition;
                    }
                  });
                },
                onVerticalDragEnd: (details) {
                  setState(() {
                    {
                      if (_sheetPosition > screenHeight / 2) {
                        _sheetPosition = screenHeight;
                      } else {
                        _sheetPosition = 0;
                      }
                    }
                  });
                },
                child: Container(
                  height: screenHeight,
                  color: Colors.white,
                  child: Column(

                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              _sheetPosition = screenHeight;
                            });
                          }, icon: Icon(Icons.arrow_back))
                        ],
                      ),
                      Text(
                        "Bottom Sheet Content",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
