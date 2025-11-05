import 'package:ecomm_395/data/remote/model/cart_model.dart';
import 'package:ecomm_395/ui/bloc/cart_bloc/cart_bloc.dart';
import 'package:ecomm_395/ui/bloc/cart_bloc/cart_event.dart';
import 'package:ecomm_395/ui/bloc/cart_bloc/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/utils/app_routes.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isCartLoaded = true;
  int quantityInt = 1;
  bool isCartEmpty = false;
  bool decrementFlag = true;
  double totalAmount = 0.0;
  int eachCartItemPrice = 0;


  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 55,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(CupertinoIcons.back, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),


      // Body Content
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<CartBloc, CartState>(
                listenWhen: (ps, cs) {
                  return decrementFlag = true;
                },
                buildWhen: (ps, cs) {
                  return decrementFlag = true;
                },
                listener: (context, state) {
                  if (state is CartFailureState) {
                    isCartEmpty = true;
                    setState(() {});
                  }

                  if (state is DecrementQtySuccessState) {
                    decrementFlag = true;
                    setState(() {});

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.successMsg)));
                  }

                  if (state is DecrementQtyErrorState) {
                    decrementFlag = false;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }

                  /*if(state is CartSuccessState){
                    totalAmount;
                    setState(() {

                    });
                  }*/


                },

                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }

                  if (state is CartFailureState) {
                    return Center(child: Text(state.errorMsg));
                  }

                  if (state is CartSuccessState) {

                    return state.allCartItems != null &&
                            state.allCartItems!.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.allCartItems!.length,
                            itemBuilder: (context, index) {


/*                              eachCartItemPrice = int.parse(state.allCartItems![index].price!)*
                                  state.allCartItems![index]
                                      .quantity!;*/

                              for(var item in state.allCartItems!){
                              double amt = double.parse(item.price!);
                              totalAmount += amt*
                                  item.quantity!;
                              }




                              return Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Product Image
                                      Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Image.network(
                                          state.allCartItems![index].imageUrl!,
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 15),

                                      // Product Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                              state.allCartItems![index].name!,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "Woman Fashion",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "\$${int.parse(state.allCartItems![index].price!)*
                                                  state.allCartItems![index]
                                                      .quantity!}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Quantity + Delete
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                DeleteCartEvent(
                                                  cartId: state
                                                      .allCartItems![index]
                                                      .id!,
                                                  productId: state
                                                      .allCartItems![index]
                                                      .productId!,
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.delete,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    int qty = state
                                                        .allCartItems![index]
                                                        .quantity!;

                                                    if (qty > 1) {
                                                      context.read<CartBloc>().add(
                                                        DecrementQtyEvent(
                                                          id: state
                                                              .allCartItems![index]
                                                              .id!,
                                                          productId: state
                                                              .allCartItems![index]
                                                              .productId!,
                                                          qty: 1,
                                                        ),
                                                      );

                                                    } else {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "Uh oh! Quantity is 1",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  state
                                                      .allCartItems![index]
                                                      .quantity
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context.read<CartBloc>().add(
                                                      DecrementQtyEvent(
                                                        id: state
                                                            .allCartItems![index]
                                                            .id!,
                                                        productId: state
                                                            .allCartItems![index]
                                                            .productId!,
                                                        qty: -1,
                                                      ),
                                                    );

                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: Text("No items in the cart"));
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),

      bottomSheet: isCartEmpty
          ? Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
          : Container(
        padding: const EdgeInsets.all(20),
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 320,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      hintText: 'Enter Discount Code',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  "Subtotal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "\$$totalAmount",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "\$$totalAmount",
                  style:TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: BlocConsumer<CartBloc, CartState>(
                listener: (_, state) {
                  if (state is CartLoadingState) {
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  }

                  if (state is CartCreateOrderFailureState) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "uh ohh!",
                            style: TextStyle(color: Colors.orange),
                          ),
                          content: Text(state.errorMsg),
                          actions: [
                            /*TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text("Cancel"),
                            ),*/
                            ElevatedButton(
                              autofocus: false,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              onPressed: () async {
                                await Navigator.pushNamed(
                                  context,
                                  AppRoutes.dashboard_page,
                                );
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    /*ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                      ),
                    );*/
                  }

                  if (state is CartCreateOrderSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.SuccessMsg),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushNamed(
                      context,
                      AppRoutes.dashboard_page,
                    );
                  }
                },

                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),

                    onPressed: /*isCartEmpty? null:*/ () {
                      context.read<CartBloc>().add(
                        CreateOrderCartEvent(),
                      );
                    },
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }

}
