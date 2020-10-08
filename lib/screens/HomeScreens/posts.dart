import 'dart:async';
import 'dart:math';
import 'package:cyclist/Controllers/blocs/Posts/posts_bloc.dart';
import 'package:cyclist/models/posts/posts_response.dart';
import 'package:cyclist/screens/HomeScreens/article.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cyclist/utils/extensions.dart';

class Article extends StatefulWidget {
  final String title;
  final String coverImageUrl;
  final int categoryId;
  const Article({Key key, this.title, this.coverImageUrl, this.categoryId}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  ScrollController _scrollController;
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController()..addListener(_onScroll);
    BlocProvider.of<PostsBloc>(context).add(LoadPosts(categoryId: widget.categoryId, status: "initial"));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  bool _block = false;
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 10) {
      if (_block) return;
      _block = true;
      print("#LOAD MORE DATA");
      BlocProvider.of<PostsBloc>(context).add(LoadPosts(categoryId: widget.categoryId, status: "initial"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: NetworkingPageHeader(
              minExtent: 150.0,
              maxExtent: 250.0,
              coverImageUrl: widget.coverImageUrl,
              title: widget.title,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),
          SliverFillRemaining(
            child: BlocConsumer<PostsBloc, PostsState>(
              listener: (context, state) {
                if (state is LoadingPosts || state is PostsInitial) {
                  _block = true;
                } else if (state is LoadingPostsFailed) {
                  _block = false;
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                } else if (state is PostsLoaded) {
                  _block = false;
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                }
              },
              builder: (context, state) {
                if (state is LoadingPosts || state is PostsInitial) {
                  return AdaptiveProgessIndicator();
                } else if (state is LoadingPostsFailed) {
                  print(state.message);
                  return CenterError(
                    margin: EdgeInsets.only(top: 100),
                    mainAxisAlignment: MainAxisAlignment.start,
                    icon: FontAwesomeIcons.heartBroken,
                    message: trs.translate("rating_error"),
                    buttomText: trs.translate("refresh"),
                    onReload: () async {
                      BlocProvider.of<PostsBloc>(context).add(LoadPosts(categoryId: widget.categoryId, status: "refresh"));
                    },
                  );
                } else if (state is PostsLoaded) {
                  final List<Post> posts = state.posts;
                  if (posts.isEmpty) {
                    return CenterError(
                      margin: EdgeInsets.only(top: 100),
                      mainAxisAlignment: MainAxisAlignment.start,
                      icon: FontAwesomeIcons.heartBroken,
                      message: trs.translate("no_posts"),
                    );
                  }
                  return AnimationLimiter(
                    child: ListView.separated(
                      padding: EdgeInsets.only(bottom: size.height * 0.05),
                      itemCount: !state.hasNextPage ? posts.length : posts.length + 1,
                      controller: _scrollController,
                      separatorBuilder: (context, index) => Container(),
                      itemBuilder: (context, index) {
                        if (index >= posts.length)
                          return AdaptiveProgessIndicator();
                        else {
                          final post = posts[index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: -50.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: CColors.darkGreenAccent, width: 1.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CColors.darkGreenAccent.withAlpha(30),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            platformPageRoute(
                                              context: context,
                                              builder: (context) => HomeArticl(
                                                post: post,
                                              ),
                                            ));
                                      },
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(post.imageHeader),
                                      ),
                                      title: Text(post.titel),
                                      subtitle: ShowMoreText(
                                        post.post * 3,
                                        maxLength: 30,
                                        style: TextStyle(fontSize: 12),
                                        showMoreText: '',
                                      ),
                                      trailing: Text(
                                        trs.translate("published_in") + "\n" + post.createdAt.daySlashMonthSlashYear,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CColors.boldBlack,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
                return AdaptiveProgessIndicator();
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    this.minExtent,
    @required this.maxExtent,
    this.coverImageUrl,
    this.title,
    this.leading,
  });
  final double minExtent;
  final double maxExtent;
  final String coverImageUrl;
  final String title;
  final Widget leading;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final AppTranslations trs = AppTranslations.of(context);
    final Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          child: FancyShimmerImage(
            imageUrl: coverImageUrl,
            boxFit: BoxFit.cover,
            shimmerBaseColor: Colors.grey[300],
            shimmerHighlightColor: Colors.grey[100],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black87],
              stops: [0.4, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16.0,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            ),
          ),
        ),
        Align(
          alignment: trs.isArabic ? Alignment(0.9, -0.55) : Alignment(-0.9, -0.55),
          child: Container(
            child: Opacity(
              opacity: titleOpacity(shrinkOffset),
              child: leading ??
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Center(
                        child: LangReversed(
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: size.aspectRatio * 50,
                                color: Colors.black,
                              ),
                            ),
                            replacment: Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: size.aspectRatio * 50,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  TickerProvider get vsync => null;
}
