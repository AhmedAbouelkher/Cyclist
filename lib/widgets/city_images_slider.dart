import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyclist/widgets/custom_page_transition.dart';
import 'package:cyclist/widgets/image_preview.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatefulWidget {
  final List<String> images;

  ///Default = `0.3`
  final double heightFactor;

  ///default = `0`
  final double correctionRaduis;

  ///default = `0.8`
  final double viewportFraction;

  final double aspectRatio;

  final bool enableSlideImagePreview;
  ImagesSlider({
    Key key,
    @required this.images,
    this.heightFactor = 0.3,
    this.viewportFraction = 0.8,
    this.aspectRatio = 16 / 9,
    this.enableSlideImagePreview = true,
    this.correctionRaduis,
  }) : super(key: key);

  @override
  _ImagesSliderState createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  CarouselController _carouselController;

  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * widget.heightFactor * 1.12,
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: widget.viewportFraction,
          height: size.height * widget.heightFactor,
          aspectRatio: widget.aspectRatio,
          initialPage: 0,
          reverse: true,
          enlargeCenterPage: true,
        ),
        itemCount: widget.images.length,
        itemBuilder: (_, index) {
          final slide = widget.images[index];
          Widget child = Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1.5),
                  color: Colors.grey[400],
                  spreadRadius: .5,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              child: FancyShimmerImage(
                imageUrl: slide,
                width: size.width,
                boxFit: BoxFit.cover,
              ),
            ),
          );
          return GestureDetector(
            onTap: () {
              if (!widget.enableSlideImagePreview) return;
              Navigator.push(
                context,
                CustomPageRoute(
                  builder: (context) => ImagePreviewer(
                    slide: slide,
                    images: widget.images,
                    onDespose: (currentIndex, initialIndex) {
                      _carouselController.animateToPage(
                        currentIndex,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.decelerate,
                      );
                    },
                  ),
                ),
              );
            },
            child: child,
          );
        },
      ),
    );
  }
}
