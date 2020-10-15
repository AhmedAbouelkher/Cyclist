import 'dart:async';
import 'package:cyclist/Controllers/blocs/RideComments/ridecomments_bloc.dart';
import 'package:cyclist/Controllers/repositories/home/repository.dart';
import 'package:cyclist/models/Rides/ride_data.dart' hide Ride;
import 'package:cyclist/models/Rides/rides_response.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cyclist/utils/extensions.dart';
import 'package:intl/intl.dart' hide TextDirection;

class RideComments extends StatefulWidget {
  final Ride ride;
  const RideComments({Key key, this.ride}) : super(key: key);

  @override
  _RideCommentsState createState() => _RideCommentsState();
}

class _RideCommentsState extends State<RideComments> {
  ScrollController _scrollController;
  Completer<void> _refreshCompleter;
  TextEditingController _textEditingController;
  bool _isLoading = false;

  HomeRepo _homeRepo;
  @override
  void initState() {
    _homeRepo = HomeRepo();
    _textEditingController = TextEditingController();
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController()..addListener(_onScroll);
    BlocProvider.of<RidecommentsBloc>(context).add(GetRideComments(
      key: UniqueKey(),
      rideId: widget.ride.id,
      status: "initial",
    ));
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
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
      BlocProvider.of<RidecommentsBloc>(context).add(GetRideComments(key: UniqueKey()));
    }
  }

  void _makeComment() async {
    setState(() => _isLoading = true);

    try {
      await _homeRepo.makeComment(rideId: widget.ride.id, comment: _textEditingController.text.trim());
      BlocProvider.of<RidecommentsBloc>(context).addComment(rideId: widget.ride.id, comment: _textEditingController.text.trim());
      _textEditingController?.clear();
      // _scrollController?.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final trs = AppTranslations.of(context);
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: StanderedAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, size, trs),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<RidecommentsBloc>(context).add(GetRideComments(key: UniqueKey(), status: "swipe-refresh"));
                    return _refreshCompleter.future;
                  },
                  child: BlocConsumer<RidecommentsBloc, RidecommentsState>(
                    listener: (context, state) {
                      if (state is LoadingComments || state is RidecommentsInitial) {
                        _block = true;
                      } else if (state is CommentsLoadedFailed) {
                        _block = false;
                        _refreshCompleter?.complete();
                        _refreshCompleter = Completer();
                      } else if (state is CommentsLoadedSuccessfuly) {
                        _block = false;
                        _refreshCompleter?.complete();
                        _refreshCompleter = Completer();
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingComments || state is RidecommentsInitial) {
                        return AdaptiveProgessIndicator();
                      } else if (state is CommentsLoadedFailed) {
                        print(state.message);
                        return CenterError(
                          margin: EdgeInsets.only(top: 100),
                          mainAxisAlignment: MainAxisAlignment.start,
                          icon: FontAwesomeIcons.heartBroken,
                          message: trs.translate("rating_error"),
                          buttomText: trs.translate("refresh"),
                          onReload: () async {
                            BlocProvider.of<RidecommentsBloc>(context).add(GetRideComments(key: UniqueKey(), status: "refresh"));
                          },
                        );
                      } else if (state is CommentsLoadedSuccessfuly) {
                        final List<Comment> comments = BlocProvider.of<RidecommentsBloc>(context).comments;
                        if (comments.isEmpty) {
                          return CenterError(
                            margin: EdgeInsets.only(top: 100),
                            mainAxisAlignment: MainAxisAlignment.start,
                            icon: FontAwesomeIcons.heartBroken,
                            message: trs.translate("no_comments_found"),
                          );
                        }
                        return AnimationLimiter(
                          child: ListView.separated(
                            padding: EdgeInsets.only(bottom: size.height * 0.05),
                            itemCount: !state.hasNextPage ? comments.length : comments.length + 1,
                            controller: _scrollController,
                            separatorBuilder: (context, index) => Container(),
                            itemBuilder: (context, index) {
                              if (index >= comments.length)
                                return AdaptiveProgessIndicator();
                              else {
                                final comment = comments[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 20.0,
                                    child: FadeInAnimation(
                                      child: Container(
                                        color: index.isEven ? Colors.grey[100] : Colors.grey[50],
                                        child: ListTile(
                                          leading: CircleAvatar(radius: 15, child: Text("#${comment.id}", style: TextStyle(fontSize: 9))),
                                          title: Text(comment.comment, style: TextStyle(fontSize: 14)),
                                          trailing: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(comment.createdAt.dayMonthNonUSFormate, style: TextStyle(fontSize: 10)),
                                              Text(
                                                DateFormat.jm().format(comment.createdAt),
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(fontSize: 9, color: CColors.darkGreenAccent),
                                              ),
                                            ],
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
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Directionality(
                        textDirection: trs.directionReversed,
                        child: IgnorePointer(
                          ignoring: _isLoading,
                          child: InkWell.noSplash(
                            onTap: _makeComment,
                            child: CircleAvatar(
                              radius: 25,
                              child: _isLoading ? AdaptiveProgessIndicator(cupetinoRadius: 10) : Icon(Icons.send, color: CColors.darkGreenAccent),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.multiline,
                        cursorColor: Color(0xFF707070).withOpacity(0.45),
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: Color(0xFF707070).withOpacity(0.45),
                          hintText: trs.translate("write_a_comment"),
                          hintStyle: TextStyle(color: Color(0xFF707070).withOpacity(0.45), fontSize: 14.0),
                          enabledBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: CColors.darkGreenAccent)),
                          focusedBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: CColors.darkGreenAccent)),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: CColors.darkGreenAccent)),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildHeader(BuildContext context, Size size, AppTranslations trs) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: CColors.darkGreenAccent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: LangReversed(
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: size.aspectRatio * 50,
                            color: Colors.white,
                          ),
                        ),
                        replacment: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: size.aspectRatio * 50,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),
          Center(child: Text(trs.translate("comments"), style: TextStyle(color: CColors.boldBlack, fontSize: 20 * .8))),
        ],
      ),
    );
  }
}
