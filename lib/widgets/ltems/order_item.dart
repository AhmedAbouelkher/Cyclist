import 'package:cyclist/models/responses/user_orders_response.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  final Function onClick;
  OrderItem({this.order, this.onClick});
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  int _statusIndex;
  @override
  void initState() {
    _statusIndex = widget.order.statusIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppTranslations trs = AppTranslations.of(context);
    final List<String> _orderStatusText = [
      trs.translate("show_order_details"),
      // trs.translate("order_details"),
      trs.translate("show_order_details"),
      // trs.translate("show_order_details"),
      trs.translate("show_order_details"),
      // trs.translate("finish_order"),
      trs.translate("show_order_details"),
    ];
    final List<Color> _orderStatusCardTextColor2 = [
      CColors.darkBlue,
      CColors.orderStatusOnItsWay,
      CColors.activestarColor,
      CColors.darkBlue,
    ];
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        width: size.width * 0.93,
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.02,
        ),
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildOrderImage(size),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.order.products.first.name + " ...",
                        style: TextStyle(
                          color: CColors.statusBarClolor,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.grey,
                            size: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              width: size.width * 0.3,
                              child: ShowMoreText(
                                widget.order.address,
                                maxLength: 80,
                                style: TextStyle(fontSize: 11),
                                showMoreText: '',
                                showMoreStyle: TextStyle(fontSize: 11),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: _buildOrderStatus(trs),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Divider(
                thickness: 0.7,
                endIndent: 20,
                indent: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                _orderStatusText[_statusIndex],
                style: TextStyle(
                  fontSize: 15,
                  color: _orderStatusCardTextColor2[_statusIndex],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildOrderStatus(AppTranslations trs) {
    DateTime date = DateTime.parse(widget.order.createdAt);
    String dateInStr = "${date.day} - ${date.month} - ${date.year}";
    // final List<String> _orderStatusCardText = [
    //   trs.translate("new_order_status"),
    //   trs.translate("order_in_processing_status"),
    //   trs.translate("order_on_its_way_status"),
    // ];
    // List<String> _status = widget.order.status.split(" ");
    final List<Color> _orderStatusCardTextColor = [
      CColors.darkBlue,
      CColors.orderStatusOnItsWay,
      CColors.blueStatusColor,
      Colors.green,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 2,
          ),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: _orderStatusCardTextColor[widget.order.statusIndex],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.order.status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                dateInStr,
                style: TextStyle(
                  color: CColors.appBarColor,
                  fontSize: 14,
                ),
              ),
              Text(
                "#${widget.order.id}",
                style: TextStyle(
                  color: CColors.appBarColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOrderImage(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: <Widget>[
            Center(
              child: FancyShimmerImage(
                imageUrl: widget.order.products.first.imagePath,
                boxFit: BoxFit.fill,
                width: size.width * 0.2,
                height: size.height * 0.09,
                shimmerBaseColor: Colors.grey[300],
                shimmerHighlightColor: Colors.grey[100],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 20,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 4],
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ).createShader(
                    Rect.fromLTRB(0, -20, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.srcIn,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
