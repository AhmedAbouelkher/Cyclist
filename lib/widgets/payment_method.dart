import 'package:flutter/material.dart';

enum PaymentMethods { cash, payLink }

typedef PaymantMethod = void Function(PaymentMethods paymentMethod);

class PaymentOptionsRow extends StatefulWidget {
  final PaymentMethods paymentMethods;
  final PaymantMethod onChoose;

  const PaymentOptionsRow({Key key, this.paymentMethods, this.onChoose}) : super(key: key);
  @override
  _PaymentOptionsRowState createState() => _PaymentOptionsRowState();
}

class _PaymentOptionsRowState extends State<PaymentOptionsRow> {
  PaymentMethods _paymentMethod;
  @override
  void initState() {
    _paymentMethod = widget.paymentMethods ?? PaymentMethods.cash;
    if (widget.onChoose != null) widget.onChoose(_paymentMethod);
    super.initState();
  }

  @override
  void didUpdateWidget(PaymentOptionsRow oldWidget) {
    if (oldWidget.paymentMethods != widget.paymentMethods) {
      _paymentMethod = widget.paymentMethods;
      if (widget.onChoose != null) widget.onChoose(_paymentMethod);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() => _paymentMethod = PaymentMethods.cash);
            if (widget.onChoose != null) widget.onChoose(_paymentMethod);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("cash", style: TextStyle(color: Colors.black, fontSize: 17)),
              SizedBox(width: 6),
              SizedBox(
                width: size.width * 0.05,
                height: size.width * 0.05,
                child: Radio(
                  value: PaymentMethods.cash,
                  groupValue: _paymentMethod,
                  onChanged: (PaymentMethods value) {
                    setState(() => _paymentMethod = value);
                    if (widget.onChoose != null) widget.onChoose(_paymentMethod);
                  },
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() => _paymentMethod = PaymentMethods.payLink);
            if (widget.onChoose != null) widget.onChoose(_paymentMethod);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                "https://paylink.sa/assets/img/logo.png",
                height: 30,
                width: 60,
              ),
              SizedBox(width: 5),
              SizedBox(
                width: size.width * 0.05,
                height: size.width * 0.05,
                child: Radio(
                  value: PaymentMethods.payLink,
                  groupValue: _paymentMethod,
                  onChanged: (PaymentMethods value) {
                    setState(() => _paymentMethod = value);
                    if (widget.onChoose != null) widget.onChoose(_paymentMethod);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
