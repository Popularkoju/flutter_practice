
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BottomSheetManagement with DiagnosticableTreeMixin, ChangeNotifier {
  int _currentCarouselIndex = 0;
  bool _isFlickering = false;
  double _offset = 0;
  double midpoint = 340;
  double headerHeight = 60;
  double lastOffsetBreakpoint = 0;
  double currentDelta = 0;

  bool _atTop = false;


  bool get atTop => _atTop;

  set atTop(bool value) {
    _atTop = value;
    notifyListeners();
  } // double getContainerHeight() {
  //   if (Roles.cont(OrderRoles.ORorderRolesCancellation) ||
  //       Roles.cont(DeliveryRoles.ORdeliveryRolesDelivery)) {
  //     return 300;
  //   }else{
  //     return 250;
  //   }
  //
  // }

  toggle(double height) {
    if (_offset == 0) {
      _offset = midpoint;
    }
    else if (_offset == height) {
      _offset = midpoint;
    } else if (lastOffsetBreakpoint == 0) {
      _offset = height;
      lastOffsetBreakpoint = _offset;
    }
    else {
      _offset = 0;
      lastOffsetBreakpoint = _offset;
    }
    notifyListeners();
  }

  toggleExpand() {
    // if (panelController.isAttached) {
    //   panelController.open();
    // }
    _offset = midpoint;
    notifyListeners();
  }

  dragging(DragUpdateDetails details) {
    print(details.delta.dy);
    double newOffset = offset - details.delta.dy;
    // if (newOffset >= midpoint) {
    //   offset= offset -details.delta.dy;
    // }
    _offset = offset - details.delta.dy;
    currentDelta -= details.delta.dy;
    notifyListeners();
  }

  endDragging(double height, context) {
    if (_offset > midpoint) {
      if (currentDelta < -10) {
        _offset = 0;
        lastOffsetBreakpoint = _offset;

        atTop = false;
      }else{
        _offset = MediaQuery.of(context).size.height -(100);

        atTop = true;
      }


      // if (currentDelta < 10) {
      //   _offset = midpoint;
      // }

    } else {
      if (currentDelta > 10) {
        _offset = midpoint;
        atTop = false;
      }
      if (currentDelta < -10) {
        _offset = 0;
        lastOffsetBreakpoint = _offset;
        atTop = false;
      }
    }
    _isFlickering = false;
    currentDelta = 0;
    notifyListeners();
  }

  int get currentCarouselIndex => _currentCarouselIndex;

  set currentCarouselIndex(int value) {
    _currentCarouselIndex = value;
    notifyListeners();
  }

  bool get isFlickering => _isFlickering;

  set isFlickering(bool value) {
    if (value == true && offset > 0) {
      return;
    }
    _isFlickering = value;
    // notifyListeners();
  }

  double get offset => _offset;

  set offset(double value) {
    _offset = value;
    isFlickering = false;
    notifyListeners();
  }
}


class SlidingUpHeader extends StatefulWidget {
  // final List orders;
  final double height;

  SlidingUpHeader(this.height);

  @override
  State<SlidingUpHeader> createState() => _SlidingUpHeaderState();
}

class _SlidingUpHeaderState extends State<SlidingUpHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return context.watch<BottomSheetManagement>().isFlickering
    //     ? FadeTransition(
    //     opacity: _animationController, child: myWidget(widget.height))
    //     :
   return myWidget(widget.height);
  }

  Widget myWidget(height) {
    BottomSheetManagement read = context.read<BottomSheetManagement>();
    BottomSheetManagement watch = context.watch<BottomSheetManagement>();
    return GestureDetector(
      onTap: () => context.read<BottomSheetManagement>().toggle(height),
      onVerticalDragUpdate: read.dragging,
      onVerticalDragEnd: (_) => read.endDragging(height, context),
      child: Container(
        height: height+read.offset,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: !watch.atTop ?  BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ): null,
        ),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Container(
              height: 6,
              width: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0XFF8E8D8D)),
            ),
            const SizedBox(height: 4),
            // Text(
            //   " Orders Ongoing",
            //   style: TextStyle(
            //     color: Theme.of(context).primaryColor,
            //     fontSize: 15,
            //     fontWeight: FontWeight.bold,
            //   ),
            //
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  ...  List.generate(10, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(),
                  ))
                
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Sca extends StatefulWidget {
  const Sca({super.key});

  @override
  State<Sca> createState() => _ScaState();
}

class _ScaState extends State<Sca> {

  @override
  Widget build(BuildContext context) {
    BottomSheetManagement watch = context.watch<BottomSheetManagement>();
    BottomSheetManagement read = context.read<BottomSheetManagement>();
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width;
    double cardWidth = width;
    double boxHeight = height-100;
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.grey,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
Center(child: Container(height: 500,)),
            Positioned(
                top: boxHeight - watch.offset,
                height: height,
                width: width,
              child: Column(
                children: [
                  SlidingUpHeader(50),
                  Expanded(child: Container(
                    color: Colors.red,
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}
