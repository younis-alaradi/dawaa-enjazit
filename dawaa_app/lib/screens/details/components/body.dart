import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dawaa_app/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';
import 'package:dawaa_app/components/default_button.dart';
import 'package:dawaa_app/models/Product.dart';
import 'package:dawaa_app/size_config.dart';
import 'package:dawaa_app/models/Cart.dart';
import '../../../constants.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;


  const Body({Key key, @required this.product}) : super(key: key);
  List getitemsonCart()
  {
    return Cart.carts;
  }

  @override
  Widget build(BuildContext context) {


    return Container(
    child:
      Column(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(

                      color: Colors.white,
                      child: DefaultButton(
                          text: "Add To Cart",
                          press: ()
                          {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              headerAnimationLoop: true,
                              animType: AnimType.LEFTSLIDE,
                              title: 'Are you sure to add this '+product.title +' ?',
                              desc: 'Pharmacy Name goes here ',
                              buttonsTextStyle: TextStyle(color: Colors.black),
                              showCloseIcon: true,
                              btnOkText: "Yes",
                              btnOkOnPress: ()
                              {

                                print(product.title+" Added to cart");
                                Cart.carts.add(Cart(product: product,numOfItem: ColorDots.cart_items));
                                HomeHeader.refreshCart_count();
                                Cart.total_price+=(product.price*ColorDots.cart_items);
                                print(product.title+" || Quantity ${ColorDots.cart_items} || Product added successfully");
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  headerAnimationLoop: true,
                                  animType: AnimType.LEFTSLIDE,
                                  title: 'Product added successfully '+product.title ,
                                  desc: 'Please ignore the quantity after adding ',
                                  buttonsTextStyle: TextStyle(color: Colors.black),
                                  showCloseIcon: false,
                                  autoHide: Duration(seconds: 5),

                                )..show();

                                ColorDots.cart_items=1;

                                getitemsonCart();
                                (context as Element).markNeedsBuild();
                              },
                              btnCancelColor: kPrimaryColor,
                              btnCancelText: "No ",
                              btnCancelOnPress: ()
                              {
                                print("Cancel add "+product.title);


                                getitemsonCart();
                                (context as Element).markNeedsBuild();
                              },

                            )..show();
                            print("Will add item soon ");

                          },
                        ),
                      ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
