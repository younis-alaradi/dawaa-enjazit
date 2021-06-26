import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dawaa_app/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dawaa_app/components/default_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$${Cart.total_price.toStringAsFixed(3)}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: (){
                      Random Rde = new Random();
                      int orderTracker = Rde.nextInt(10000);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.QUESTION,
                        headerAnimationLoop: true,
                        animType: AnimType.LEFTSLIDE,
                        title: 'Your Order',
                        desc: 'Total Cost : \$${Cart.total_price.toStringAsFixed(3)}'
                            '\nOrder tracker : $orderTracker',
                        buttonsTextStyle: TextStyle(color: Colors.black),
                        showCloseIcon: true,
                        btnOkText: "Confirm",
                        btnOkOnPress: ()
                        {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO,
                            headerAnimationLoop: true,
                            animType: AnimType.LEFTSLIDE,
                            title: 'Order No. $orderTracker | added successfully ',
                            desc: 'Please be patience , Maximum delivery time : 50 minutes ',
                            buttonsTextStyle: TextStyle(color: Colors.black),
                            showCloseIcon: false,
                            autoHide: Duration(seconds: 10),

                          )..show();

                          (context as Element).markNeedsBuild();
                        },
                        btnCancelColor: kPrimaryColor,
                        btnCancelText: "No ",
                        btnCancelOnPress: ()
                        {
                        },

                      )..show();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
