import 'package:dawaa_app/components/coustom_bottom_nav_bar.dart';
import 'package:dawaa_app/components/product_card.dart';
import 'package:dawaa_app/screens/details/details_screen.dart';
import 'package:dawaa_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../constants.dart';
import '../size_config.dart';
import '../enums.dart';

class fav_items extends StatelessWidget {


  static String routeName = 'lib/favorite_list/Fav_items.dart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hide the debug banner
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  favPageState createState() => favPageState();
}

class favPageState extends State<HomePage> {
   List<ProductCard>_favorite_items = [];

  static List getListOfFavorite()
  {

    return ProductCard.fav;
  }
    void refreshList()
  {
    _favorite_items = getListOfFavorite();
  }

String status ;
  @override
  void initState() {
    super.initState();

    getListOfFavorite();
    _favorite_items = getListOfFavorite();
    if(_favorite_items.length==0) {
      status ="No";
      print("No items in lists");
    }
    else {print("There is items");status="Yes";}
  }



  Widget build(BuildContext context) {
    final double width = 140;
    final double aspectRatio = 1.02;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          tooltip: "Back to home Page ",
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Text(
          'Favorite items',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
          child:ListView.builder(
            itemCount: _favorite_items.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _favorite_items.length > 0
                      ? Padding(
                    padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                    child: SizedBox(
                      width: getProportionateScreenWidth(width),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(product: _favorite_items[0].product),
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
                                  tag: _favorite_items[index].product.id,
                                  child: Image.asset(_favorite_items[index].product.images[0]),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _favorite_items[index].product.title,
                              style: TextStyle(color: Colors.black),
                              maxLines: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${_favorite_items[index].product.price}",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18),
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ) :
                  Container(
                    child: Align
                      (alignment: Alignment.center,
                      child: IconButton
                        (icon: Icon(Icons.integration_instructions),
                        onPressed: ()
                        {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO,
                            headerAnimationLoop: true,
                            animType: AnimType.LEFTSLIDE,
                            title: 'Dawaa , favorite manager ',
                            desc: 'Please add some products to be shown in favorite list',
                            buttonsTextStyle: TextStyle(color: Colors.black),
                            showCloseIcon: true,
                            btnOkOnPress: (){},
                          )..show();
                          },
                      ) ,
                    ),
                  ),
                ],
              );
              },
          )
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu:MenuState.favourite),
    );
  }
}
