import 'dart:async';
import 'dart:ui';

import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';

class DayImages {
  String dayImages;
  int milliseconds;
  double progress;

  DayImages(
      {required this.dayImages, required this.milliseconds, this.progress = 0});
}

class Story {
  List<DayImages> dayImages;

  Story({required this.dayImages});
}

List<Story> stories = [
  Story(
    dayImages: [
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 1000),
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 3000),
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 2000),
    ],
  ),
  Story(
    dayImages: [
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 5000),
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 3000),
    ],
  ),
  Story(
    dayImages: [
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 5000),
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 3000),
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 2000),
      DayImages(dayImages: 'https://picsum.photos/200/300', milliseconds: 1000),
    ],
  )
];

class CubeTrasitionDemo extends StatefulWidget {
  const CubeTrasitionDemo({super.key});

  @override
  State<CubeTrasitionDemo> createState() => _CubeTrasitionDemoState();
}

class _CubeTrasitionDemoState extends State<CubeTrasitionDemo> {
  PageController cubTransitionController = PageController();

  changePage() {
    if (stories.length > cubTransitionController.page!.round()) {
      cubTransitionController.nextPage(
          duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: CubePageView.builder(
              controller: cubTransitionController,
              itemCount: stories.length,
              itemBuilder: (context, index, notifier) {
                final item = stories[index];
                final transform = Matrix4.identity();
                final t = (index - notifier).abs();
                final scale = lerpDouble(1.5, 0, t);
                transform.scale(scale, scale);
                return CubeWidget(
                  index: index,
                  pageNotifier: notifier,
                  child: Stack(
                    children: [
                      SinglePersonStory(
                        dayImages: item.dayImages,
                        changePage: changePage,
                      ),
                      // Transform(
                      //   alignment: Alignment.center,
                      //   transform: transform,
                      //   child: Center(
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(12.0),
                      //       child: Container(
                      //         decoration: const BoxDecoration(boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.black45,
                      //             spreadRadius: 5,
                      //             blurRadius: 5,
                      //           ),
                      //         ]),
                      //         child: Text(
                      //           "Test ${index + 1}",
                      //           textAlign: TextAlign.center,
                      //           style: Theme.of(context).textTheme.headline5,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SinglePersonStory extends StatefulWidget {
  final List<DayImages> dayImages;
  final VoidCallback changePage;

  const SinglePersonStory(
      {super.key, required this.dayImages, required this.changePage});

  @override
  State<SinglePersonStory> createState() => _SinglePersonStoryState();
}

class _SinglePersonStoryState extends State<SinglePersonStory> {
  int viewingIndex = 0;
  late Timer? _timer;
  PageController controller = PageController();
  double _progress = 0;

  @override
  void initState() {
    _startTimer();
    setState(() {});
    super.initState();
  }

  void _startTimer() {
    const tick =
        Duration(milliseconds: 100); // Update progress every 100 milliseconds
    _timer = Timer.periodic(tick, (Timer timer) {
      setState(() {
        _progress +=
            tick.inMilliseconds / (widget.dayImages[viewingIndex].milliseconds);
        widget.dayImages[viewingIndex].progress = _progress;
        if (_progress >= 1.0) {
          _progress = 1.0;
          viewingIndex++;
          if (viewingIndex >= widget.dayImages.length) {
            _timer?.cancel();
            widget.changePage.call();
            print('All objects processed!');
          } else {
            _progress = 0.0;
            controller.animateToPage(
              viewingIndex,
              duration: const Duration(milliseconds: 700),
              curve: Curves.ease,
            );
            // widget.dayImages[viewingIndex-1].progress = 0.0;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.dayImages.length,
          controller: controller,
          onPageChanged: (index) {
            viewingIndex = index;
            _progress = 0;
            // _timer?.cancel();
            // _startTimer();
          },
          itemBuilder: (context, index) {
            return Image.network(
              widget.dayImages[index].dayImages,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            );
          }),
      Row(
        children: [
          ...List.generate(
              widget.dayImages.length,
              (index) => Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: widget.dayImages[index].progress,
                      //
                    ),
                  ))),
        ],
      )
    ]);
  }
}
