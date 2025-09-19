import 'package:ecomm_395/data/remote/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {

  ProductModel currentProduct;


  ProductDetailPage({required this.currentProduct});


  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    /*final args =
        ModalRoute.of(context)?.settings.arguments as ProductModel;
*/

    final imgPath = widget.currentProduct.image;
    final name = widget.currentProduct.name;
    final price = widget.currentProduct.price;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// --- Top Image Section ---
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    children: [
                      Image.network(
                        imgPath!,
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        imgPath,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),

                  /// Back, Share, Favorite buttons
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 60,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.share, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.favorite_border, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            /// --- Details Section ---
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + Seller
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Seller: Tariqul isalm",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    /// Price
                    Text(
                      "\$${price!}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        Text(
                          "4.8 ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "(320 Review)",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Colors
                    Text("Color",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildColorCircle(Colors.red),
                        _buildColorCircle(Colors.black),
                        _buildColorCircle(Colors.blue),
                        _buildColorCircle(Colors.brown),
                        _buildColorCircle(Colors.grey),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Tabs: Description, Specs, Reviews
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.orange,
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: "Description"),
                        Tab(text: "Specifications"),
                        Tab(text: "Reviews"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                                  "Suspendisse vitae."),
                          Text("Specifications content here."),
                          Text("Reviews content here."),
                        ],
                      ),
                    ),

                    /// Quantity & Add to Cart
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) quantity--;
                                    });
                                  },
                                ),
                                Text(
                                  "$quantity",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                print("Add to Cart clicked");
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// helper widget for color circle
  Widget _buildColorCircle(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 30,
      height: 30,
      decoration:
      BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))
      ]),
    );
  }


}
