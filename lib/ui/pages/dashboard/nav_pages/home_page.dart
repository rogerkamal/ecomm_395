import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecomm_395/domain/utils/app_routes.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_bloc.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_event.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_state.dart';
import 'package:ecomm_395/ui/bloc/product_bloc/product_bloc.dart';
import 'package:ecomm_395/ui/bloc/product_bloc/product_event.dart';
import 'package:ecomm_395/ui/bloc/product_bloc/product_state.dart';
import 'package:ecomm_395/ui/custom_widgets/product_card.dart';
import 'package:ecomm_395/ui/pages/product/detail_page.dart';
// import 'package:ecomm_395/ui/pages/product/product_detail_page.dart';
// import 'package:ecomm_395/ui/pages/product/view_all_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> bannerImages = [
    "https://picsum.photos/id/1015/800/400",
    "https://picsum.photos/id/1016/800/400",
    "https://picsum.photos/id/1018/800/400",
    "https://picsum.photos/id/1021/800/400",
  ];


  List<dynamic> categoriesIcon = [
    Icons.shopping_bag,
    Icons.checkroom,
    Icons.watch,
    Icons.phone_android,
    Icons.headphones,
    Icons.computer,
    Icons.tablet,
    Icons.camera_alt_rounded,
    Icons.phone_android,
  ];



   CarouselSliderController _controller = CarouselSliderController();

   int activeIndex =0;

  List<Map<String, dynamic>> productData = [
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones",
      "productPrice": "\$120.00",
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter",
      "productPrice": "\$120.00",
    },
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones",
      "productPrice": "\$120.00",
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter",
      "productPrice": "\$120.00",
    },
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones",
      "productPrice": "\$120.00",
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter",
      "productPrice": "\$120.00",
    },
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones",
      "productPrice": "\$120.00",
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter",
      "productPrice": "\$120.00",
    },
  ];

  bool isSpecialForYou = true;

@override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(FetchProductEvent());
    context.read<CategoriesBloc>().add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0, right: 0),
                leading: Container(
                    width: 40,
                    height: 40,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200
                    ),
                  child: Image.asset('assets/images/button.png',color: Colors.grey,)),
                trailing: Container(

                  width: 40,
                  height: 40,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200
                  ),
                  child: Icon(Icons.notifications_outlined),
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 5,),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    enabled: true,
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black38,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SizedBox(
                        width: 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 2,
                              height: 20,
                              color: Colors.black38,
                            ),
                            Icon(
                              Icons.filter_list,
                              size: 25,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 10, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Stack(
                        children: [
                          CarouselSlider.builder(
                          carouselController: _controller,
                          itemCount: bannerImages.length,
                          itemBuilder: (_, index, _) {
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(bannerImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                /*Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AnimatedSmoothIndicator(
                        
                                          activeIndex: activeIndex,
                                          count: bannerImages.length,
                                          effect: ExpandingDotsEffect(
                                            paintStyle: PaintingStyle.fill,
                        
                                            activeDotColor: Colors.black,
                                            dotColor: Colors.black54,
                                            dotHeight: 5,
                                            dotWidth: 5,
                                            expansionFactor: 3,
                                            spacing: 6,
                                          ),
                                          onDotClicked: (index) => _controller.animateToPage(index),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                        
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10 , 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Super Sale\nDiscount\nUp to 50%",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20)),
                        
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        height : 30,
                                        width : 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.deepOrange
                                        ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(child: Text("Shop Now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          )
                        
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            viewportFraction: 1.0,
                            // autoPlayInterval: const Duration(seconds: 1),
                            autoPlayAnimationDuration: const Duration(seconds: 1),
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                        ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 40,
                              child: DotsIndicator(
                                dotsCount: bannerImages.length,
                                position: activeIndex.toDouble(),
                                animate: true,
                                decorator: DotsDecorator(
                                  activeSize: Size(18, 8),
                                  size: Size(8, 8),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Colors.transparent,
                                  activeColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  spacing: EdgeInsets.only(
                                    right: 3,
                                    top: 11,
                                    bottom: 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    //Categories list Row
                    BlocBuilder<CategoriesBloc, CategoriesState>(

                      builder: (context,state) {
                        if(state is CategoriesLoadingState){

                          return Center(child: CircularProgressIndicator(color: Colors.orange,));
                        }


                        if(state is CategoriesErrorState){

                          return Center(child: Text(state.errorMsg,style: TextStyle(color: Colors.red),));
                        }



                        if(state is CategoriesLoadedState){

                          return Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.allCategories.length,
                                  itemBuilder: (_,index) {
                                  return Row(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildCategory(state.allCategories[index].name!, categoriesIcon[index], state.allCategories[index].id!),
                                      SizedBox(width: 10,)
                                    ],
                                  );
                                }
                              ),
                            ),
                          );
                        }

                        return Container();

                      }
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Special For You",
                              style:
                              TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                            ),
                            Text(
                              "See all",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 150),
                          width: double.infinity,
                          child: BlocBuilder<ProductBloc,ProductState>(

                              buildWhen: (ps, cs) {
                                return isSpecialForYou;
                              },

                              builder: (context, state) {
                              if (state is ProductLoadingState){
                                return Center(child: CircularProgressIndicator(color: Colors.orange,));
                              }

                              if (state is ProductErrorState){
                                return Center(child: Text(state.errorMsg),);
                              }

                              if(state is ProductLoadedState){


                                return state.allProducts != null && state.allProducts.isNotEmpty?
                                GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    mainAxisSpacing: 11,
                                    crossAxisSpacing: 11,
                                    childAspectRatio: 8 / 9,
                                  ),
                                  itemCount: state.allProducts.length,
                                  itemBuilder: (_, index) {
                                    return ProductCard(
                                      onPress: () {
                                        // Handle product card tap
                                        //Navigator.pushNamed(context, AppRoutes.detail_page, arguments: state.mProductList[index]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailPage(
                                              currentProduct:
                                              state.allProducts[index],
                                            ),
                                          ),
                                        );
                                      },
                                      imgPath: state.allProducts[index].image!,
                                      name: state.allProducts[index].name!,
                                      price: state.allProducts[index].price!,
                                    );
                                  },
                                ): Center(child: Text("No Products Available"));
                              }

                              return Container();
                            }
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String title, IconData icon, String categoryId) {
    int categoryInt = int.parse(categoryId);
  return InkWell(
      onTap: (){
        isSpecialForYou = false;
        print("Category Clicked id ${categoryId}");
        // return ViewAllProductsPage(categoryId: categoryInt);
        Navigator.pushNamed(context, AppRoutes.view_all_products_page, arguments: categoryInt);
      },
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(icon, color: Colors.deepPurple),
            ),
            SizedBox(height: 5),
            Expanded(child: Text(title,maxLines: 2, style: TextStyle(fontSize: 12))),
          ],
        ),
      ),
    );
  }
}
