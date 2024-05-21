import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaffoldColor extends StatelessWidget {
  const ScaffoldColor({super.key});

  @override
  Widget build(BuildContext context) {
    Widget bottomBar = Container(
      margin: EdgeInsets.all(2),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(100)),
    );
    return Scaffold(
      backgroundColor: Color(0xFF452ACB),
      appBar: AppBar(
        backgroundColor: Color(0xFF452ACB),
        title: const Text(
          'Color',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // floatingActionButton:bottomBar ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: Container(
        color: Colors.white,
        child: bottomBar,
      ),
      // bottomNavigationBar:,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainScaffold extends StatelessWidget {
  bool isHomePage() {
    return navigatorKey.currentState?.canPop() == false;
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomBar = Container(
      margin: EdgeInsets.all(2),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                if (!isHomePage()) {
                  navigatorKey.currentState
                      ?.pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
              icon: Icon(Icons.home))
        ],
      ),
    );
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return CupertinoPageRoute(
            builder: (context) {
              switch (settings.name) {
                case '/':
                  return HomePage();
                case '/second':
                  return SecondPage();
                default:
                  return HomePage();
              }
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottomBar,

      // FloatingActionButton(
      //
      //
      //   onPressed: () {
      //     // Action when FAB is pressed
      //     showDialog(
      //       context: context,
      //       builder: (context) => AlertDialog(
      //         title: Text('FAB Pressed'),
      //         content: Text('You pressed the Floating Action Button.'),
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: Text('OK'),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/second');
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Back to Home Page'),
        ),
      ),
    );
  }
}
