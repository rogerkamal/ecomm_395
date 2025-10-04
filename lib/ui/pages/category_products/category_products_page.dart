import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_bloc.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_event.dart';
import 'package:ecomm_395/ui/bloc/product_bloc/product_bloc.dart';
import 'package:ecomm_395/ui/bloc/product_bloc/product_event.dart';
import 'package:ecomm_395/ui/bloc/product_bloc/product_state.dart';
import 'package:ecomm_395/ui/custom_widgets/product_card.dart';
import 'package:ecomm_395/ui/pages/product/detail_page.dart';
// import 'package:ecomm_395/ui/pages/product/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorizedProductsPage extends StatefulWidget {
  @override
  State<CategorizedProductsPage> createState() =>
      _CategorizedProductsPageState();
}

class _CategorizedProductsPageState extends State<CategorizedProductsPage> {
  int selectedIndex = 0;

  List<Color> mColors = [Colors.black, Colors.blue, Colors.orange];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int categoryId = ModalRoute.of(context)!.settings.arguments as int;
    print("catid  ${categoryId} ");
    context.read<ProductBloc>().add(FetchProductEvent(categoryId: categoryId));

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60, left: 15, right: 15),
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }

                  if (state is ProductErrorState) {
                    return Center(child: Text(state.errorMsg));
                  }

                  if (state is ProductLoadedState) {
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                                  currentProduct: state.allProducts[index],
                                ),
                              ),
                            );
                          },
                          imgPath: state.allProducts[index].image!,
                          name: state.allProducts[index].name!,
                          price: state.allProducts[index].price!,
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
