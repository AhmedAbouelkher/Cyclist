import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cyclist/Controllers/blocs/Categories/categories_bloc.dart';
import 'package:cyclist/models/Categories/categories_response.dart';
import 'package:cyclist/screens/HomeScreens/posts.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeTap extends StatefulWidget {
  @override
  _HomeTapState createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  ScrollController _scrollController;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController()..addListener(_onScroll);
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
    if (maxScroll - currentScroll <= 0) {
      if (_block) return;
      _block = true;
      print("#LOAD MORE DATA");
      BlocProvider.of<CategoriesBloc>(context).add(LoadCategories());
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.home, color: CColors.darkGreenAccent),
              SizedBox(width: 10),
              Text(trs.translate("home_tab"), style: TextStyle(color: CColors.boldBlack, fontSize: 18 * 0.8)),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: BlocConsumer<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              if (state is LoadingCategories || state is CategoriesInitial) {
                _block = true;
              } else if (state is LoadingCategoriesFailed) {
                _block = false;
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
              } else if (state is CategoriesLoaded) {
                _block = false;
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
              }
            },
            builder: (context, state) {
              if (state is LoadingCategories || state is CategoriesInitial) {
                return AdaptiveProgessIndicator();
              } else if (state is LoadingCategoriesFailed) {
                print(state.message);
                return CenterError(
                  margin: EdgeInsets.only(top: 100),
                  mainAxisAlignment: MainAxisAlignment.start,
                  icon: FontAwesomeIcons.heartBroken,
                  message: trs.translate("rating_error"),
                  buttomText: trs.translate("refresh"),
                  onReload: () async {
                    BlocProvider.of<CategoriesBloc>(context).add(LoadCategories(status: "refresh"));
                  },
                );
              } else if (state is CategoriesLoaded) {
                final List<Category> categories = state.categories;
                if (categories.isEmpty) {
                  return CenterError(
                    margin: EdgeInsets.only(top: 100),
                    mainAxisAlignment: MainAxisAlignment.start,
                    icon: FontAwesomeIcons.heartBroken,
                    message: trs.translate("no_categories"),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasNextPage ? categories.length + 1 : categories.length,
                  itemBuilder: (context, index) {
                    if (index >= categories.length) {
                      return AdaptiveProgessIndicator();
                    }
                    final catrgory = categories[index];
                    return HomeItem(
                      coverImageUrl: catrgory.imageHeader,
                      title: catrgory.name,
                      onTap: () {
                        Navigator.push(
                          context,
                          platformPageRoute(
                            context: context,
                            builder: (context) => Article(
                              categoryId: catrgory.id,
                              coverImageUrl: catrgory.imageHeader,
                              title: catrgory.name,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              return AdaptiveProgessIndicator();
            },
          ),
        ),
      ],
    );
  }
}

class HomeItem extends StatelessWidget {
  final String coverImageUrl;
  final String title;

  final VoidCallback onTap;

  const HomeItem({
    Key key,
    @required this.coverImageUrl,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Container(
      height: size.height * 0.3,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: CColors.boldBlack,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.5,
            blurRadius: 15,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                    child: FancyShimmerImage(
                      imageUrl: coverImageUrl,
                      boxFit: BoxFit.cover,
                      shimmerBaseColor: Colors.grey[200],
                      shimmerHighlightColor: Colors.grey[100],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1],
                          colors: [Colors.transparent, Colors.black.withOpacity(1)],
                        ).createShader(Rect.fromLTRB(50, -200, rect.width, 0));
                      },
                      blendMode: BlendMode.srcIn,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                      ),
                    ),
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35 * 0.6,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: FadeAnimatedTextKit(
                    text: [trs.translate("click_to_learn_more")],
                    repeatForever: true,
                    textStyle: TextStyle(color: Colors.white, fontSize: 14 * 0.8),
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
