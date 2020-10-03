import 'package:cyclist/models/coupon_model.dart';
import 'package:cyclist/repos/orders_repo.dart';
import 'package:cyclist/utils/alert_manager.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/buttons/custom_main_button.dart';
import 'package:cyclist/widgets/text_feilds/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PickCouponDialog extends StatefulWidget {
  final Function onSubbmited;
  PickCouponDialog({this.onSubbmited});
  @override
  _PickCouponDialogState createState() => _PickCouponDialogState();
}

class _PickCouponDialogState extends State<PickCouponDialog> {
  final TextEditingController couponController = TextEditingController();
  Coupon copoun;
  bool isLoading = false;
  String errMsg;
  bool isValid = false;
  final OrdersRepo _ordersRepo = OrdersRepo();

  @override
  void dispose() {
    couponController?.dispose();
    super.dispose();
  }

  Widget buildCopounLogic({AppTranslations trs}) {
    if (isLoading) {
      return AdaptiveProgessIndicator();
    } else if (errMsg != null) {
      return Text(errMsg);
    } else if (copoun == null) {
      return Container();
    } else if (isValid) {
      return Text(trs.translate("valid_copuon") + copoun.value);
    } else {
      return Text(trs.translate("invalid_copuon"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.10),
          height: size.height * 0.30,
          width: size.width * 0.80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomTextFeild(
                controller: couponController,
                icon: FontAwesomeIcons.dollarSign,
                text: trs.translate('discount_copoun'),
              ),
              SizedBox(height: size.height * .02),
              buildCopounLogic(trs: trs),
              IgnorePointer(
                ignoring: isLoading,
                child: CustomMainButton(
                  text: trs.translate('confirm'),
                  height: size.height * 0.05,
                  onTap: () async {
                    bool canPop = false;
                    print('started');
                    if (couponController.text.trim().length == 0) {
                      alertWithErr(context: context, msg: trs.translate('enter_copoun'));
                      return;
                    }
                    try {
                      setState(() => isLoading = true);
                      copoun = await _ordersRepo.checkCoupon(couponController.text.trim());
                      isValid = true;
                      canPop = true;
                    } catch (e) {
                      print(e);
                      errMsg = e.toString();
                    } finally {
                      if (canPop) {
                        widget.onSubbmited(copoun);
                        Navigator.of(context).pop();
                      } else {
                        setState(() => isLoading = false);
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: size.height * .02),
            ],
          ),
        ),
      ),
    );
  }
}
