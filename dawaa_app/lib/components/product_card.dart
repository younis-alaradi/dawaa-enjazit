import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dawaa_app/screens/favorite_list/Fav_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dawaa_app/models/Product.dart';
import 'package:dawaa_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';


class ProductCard extends StatelessWidget {

  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;



  // ignore: non_constant_identifier_names
  static List<ProductCard>fav = [];


  @override
  Widget build(BuildContext context) {
    bool isfavorite = false;

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: product.id.toString(),
                    child: Image.asset(product.images[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: product.isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print("Heart icon for adding//removing to  favorite list clicked");
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
                              favPageState fave = new favPageState();
                              fave.refreshList();
                              product.isFavourite = true;
                              print(product.title+" added to favorite list");
                              fav.add(ProductCard(product: product,));
                              print(product.title+" : Product added successfully");

                              (context as Element).markNeedsBuild();
                            },
                            btnCancelColor: kPrimaryColor,
                            btnCancelText: "No ",
                            btnCancelOnPress: ()
                            {
                              favPageState.getListOfFavorite();
                              product.isFavourite = false;
                              print(product.title+" Removed from list");
                              fav.remove(ProductCard(product: product));
                              print("Product removed from list");

                              (context as Element).markNeedsBuild();
                            },

                          )..show();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          color:product.isFavourite
                              ? Color(0xFFFF4848)
                              : Color(0xFFDBDEE4),
                        ),
                      ),

                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
