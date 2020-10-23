import 'package:cyclist/models/posts/posts_response.dart';
import 'package:cyclist/screens/HomeScreens/posts.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/city_images_slider.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:cyclist/widgets/video_player_item.dart';
import 'package:flutter/material.dart';
import 'package:cyclist/utils/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class HomeArticl extends StatefulWidget {
  final Post post;
  const HomeArticl({Key key, this.post}) : super(key: key);

  @override
  _HomeArticlState createState() => _HomeArticlState();
}

class _HomeArticlState extends State<HomeArticl> {
  List<String> _images;
  List<String> _videos;
  @override
  void initState() {
    _images = [];
    _videos = [];
    widget.post.media.forEach((file) {
      if (file.madiaType == MediaType.image) {
        _images.add(file.path);
      } else {
        _videos.add(file.path);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: NetworkingPageHeader(
                minExtent: 150.0,
                maxExtent: 250.0,
                coverImageUrl: widget.post.imageHeader,
                title: widget.post.titel,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.post.post, style: TextStyle(fontSize: 11)),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),
            _images.isEmpty
                ? SliverToBoxAdapter(child: SizedBox())
                : SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider.symmetric(horizontal: 25),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.images, size: 15),
                              SizedBox(width: 10),
                              Text(
                                trs.translate("images"),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        ImagesSlider(
                          images: _images,
                          heightFactor: .25,
                          viewportFraction: 0.75,
                          aspectRatio: 2,
                          enableSlideImagePreview: true,
                        )
                      ],
                    ),
                  ),
            if (_videos.isEmpty)
              SliverToBoxAdapter(child: SizedBox())
            else
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider.symmetric(horizontal: 25),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.images, size: 15),
                          SizedBox(width: 10),
                          Text(
                            trs.translate("videos"),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    for (var index = 0; index < _videos.length; index++)
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: ChewieListItem(
                          videoPlayerController: VideoPlayerController.network(
                            _videos[index],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.03)),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(endIndent: 15, indent: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Spacer(),
                        Text(
                          trs.translate("published_in"),
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.post.createdAt.daySlashMonthSlashYear,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.05)),
          ],
        ),
      ),
    );
  }
}
