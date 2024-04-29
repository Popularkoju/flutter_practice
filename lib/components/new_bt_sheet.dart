import 'package:flutter/material.dart';

class MyDataModel {
  String title;
  String body;
  IconData iconData;

  MyDataModel(
      {required this.title, required this.body, required this.iconData});
}

List<MyDataModel> myData = <MyDataModel>[

  MyDataModel(title: 'Title 1', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 1', iconData: Icons.abc),
  MyDataModel(title: 'Title 2', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 2', iconData: Icons.abc),
  MyDataModel(title: 'Title 3', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 3', iconData: Icons.abc),
  MyDataModel(title: 'Title 4', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 4', iconData: Icons.abc),
  MyDataModel(title: 'Title 5', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 5', iconData: Icons.abc),
  MyDataModel(title: 'Title 6', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 6', iconData: Icons.abc),
  MyDataModel(title: 'Title 7', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 7', iconData: Icons.abc),
  MyDataModel(title: 'Title 8', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 8', iconData: Icons.abc),
  MyDataModel(title: 'Title 9', body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book" 9', iconData: Icons.abc),



];

class BottomSheetDemo extends StatefulWidget {
  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo>
    with SingleTickerProviderStateMixin {
  late double _sheetPosition ;
  double _maxSheetPosition = 0;
  bool  isScrollable = false;

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
  void didChangeDependencies() {
    _sheetPosition = MediaQuery.of(context).size.height/2;

    super.didChangeDependencies();
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
                      isScrollable = false;
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
                    if (_sheetPosition == 0) return;
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
                        isScrollable = true;
                      }
                    }
                  });
                },
                child: Container(
                  height: screenHeight,
                  color: Colors.white,
                  child: Column(
                    children: [
                     AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        color: isScrollable? Colors.teal:Colors.transparent,
                        // height: isScrollable?50:0,
                        child: isScrollable?Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _sheetPosition = screenHeight/2;
                                    isScrollable = false;
                                  });
                                },
                                icon: Icon(Icons.arrow_drop_down_sharp))
                          ],
                        ): const SizedBox.shrink(),
                      ),
                     BottomSheetContains(isScrollable: isScrollable),
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

class BottomSheetContains extends StatelessWidget {
final   bool isScrollable;
  const BottomSheetContains({super.key, required this.isScrollable});

  @override
  Widget build(BuildContext context) {
    List<MyDataModel> data =  myData;
    return Expanded(child: ListView.builder(
      padding: const EdgeInsets.all(8),
      physics: !isScrollable  ? const NeverScrollableScrollPhysics() : null,
    itemCount: data.length
    ,itemBuilder: (context, index) {

      return ListTile(
        title: Text(data[index].title),
        subtitle: Text(data[index].body),
        leading: Icon(data[index].iconData),
      );
    }));
  }
}

