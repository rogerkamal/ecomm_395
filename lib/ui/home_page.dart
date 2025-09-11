import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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

   CarouselSliderController _controller = CarouselSliderController();

   int activeIndex =0;

  List<Map<String, dynamic>> productData = [
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones"
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter"
    },
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones"
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter"
    },
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones"
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter"
    },
    {
      "productImgUrl": "https://picsum.photos/id/1015/800/400",
      "productText": "Wireless Headphones"
    },
    {
      "productImgUrl": "https://picsum.photos/id/1016/800/400",
      "productText": "Woman Sweter"
    },

  ];





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
                        color: Colors.black12
                    ),
                  child: Image.asset('assets/images/button.png',color: Colors.grey,)),
                trailing: Container(

                  width: 40,
                  height: 40,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12
                  ),
                  child: Icon(Icons.notifications_outlined),
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20,),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.black12,
                    filled: true,
                    enabled: true,
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black38,
                    ),
                    suffixIcon: Icon(
                      Icons.filter_list,
                      size: 30,
                      color: Colors.black38,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 25, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                      carouselController: _controller,
                      itemCount: bannerImages.length,
                      itemBuilder: (context, index, realIndex) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(bannerImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedSmoothIndicator(
                                      activeIndex: activeIndex,
                                      count: bannerImages.length,
                                      effect: ExpandingDotsEffect(
                                        activeDotColor: Colors.deepPurple,
                                        dotColor: Colors.grey,
                                        dotHeight: 8,
                                        dotWidth: 8,
                                        expansionFactor: 3,
                                        spacing: 6,
                                      ),
                                      onDotClicked: (index) => _controller.animateToPage(index),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                        height: 180,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        // autoPlayInterval: const Duration(seconds: 1),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Example Categories Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCategory("Shoes", Icons.shopping_bag),
                          _buildCategory("Clothes", Icons.checkroom),
                          _buildCategory("Watches", Icons.watch),
                          _buildCategory("Phones", Icons.phone_android),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    ///from wallpaper app
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
                        SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 500,
                              width: double.infinity,
                              child: GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      mainAxisSpacing: 11,
                                      crossAxisSpacing: 11,
                                      childAspectRatio: 16 / 9),
                                  itemCount: productData.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      width: 500,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              /*color: Colors.blueGrey*/
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider(
                                                  productData[index]['productImgUrl']
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            productData[index]
                                            ['productText'],
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
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

  Widget _buildCategory(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.deepPurple.shade100,
          child: Icon(icon, color: Colors.deepPurple),
        ),
        SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
