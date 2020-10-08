import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

typedef ValueChanged2<T> = void Function(T value1, T value2);

class ImagePreviewer extends StatefulWidget {
  final String slide;
  final List<String> images;
  final ValueChanged2<int> onDespose;

  const ImagePreviewer({Key key, @required this.slide, this.images, this.onDespose})
      : assert(slide != null),
        super(key: key);

  @override
  _ImagePreviewerState createState() => _ImagePreviewerState();
}

class _ImagePreviewerState extends State<ImagePreviewer> {
  PageController _pageController;
  int _currentIndex;
  int _initialIndex;

  @override
  void initState() {
    _currentIndex = widget.images.indexOf(widget.slide);
    if (_currentIndex == -1) _currentIndex = 0;
    _initialIndex = _currentIndex;
    _pageController = PageController(
      initialPage: _currentIndex,
      // viewportFraction: 0.85,
    );
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDespose != null) widget.onDespose(_currentIndex, _initialIndex);
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final trs = AppTranslations.of(context);
    return Theme(
      data: ThemeData(appBarTheme: AppBarTheme(brightness: Brightness.light)),
      child: SwipeGestureRecognizer(
        onSwipeDown: () => Navigator.pop(context),
        onSwipeUp: () => Navigator.pop(context),
        child: Scaffold(
          appBar: StanderedAppBar(),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  reverse: true,
                  controller: _pageController,
                  itemCount: widget.images.length,
                  onPageChanged: (value) => _currentIndex = value,
                  itemBuilder: (context, index) {
                    final _slide = widget.images[index];
                    return Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(0)),
                        child: FancyShimmerImage(
                          imageUrl: _slide,
                          width: size.width,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.3)),
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Directionality(
                              // textDirection: TextDirection.ltr,
                              textDirection: trs.directionReversed,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
