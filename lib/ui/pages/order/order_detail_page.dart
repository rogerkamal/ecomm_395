import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm_395/data/remote/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  OrderItemsModel currentOrder;


  OrderDetailPage({required this.currentOrder});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back_ios_sharp, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("order_number :${widget.currentOrder.orderNumber}",style: TextStyle(color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("total_amount :\$${widget.currentOrder.totalAmount}"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("created_at :${widget.currentOrder.createdAt}"),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.currentOrder.product!.length,
                  itemBuilder: (context,index){
                    Product orderEachProduct = widget.currentOrder.product![index];
                    return ListTile(
                      leading: Image.network(orderEachProduct.image!,height: 80,width: 80,),
                      title: Text("name :${orderEachProduct.name}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("quantity :${orderEachProduct.quantity}"),
                          Text("price :\$${orderEachProduct.price}"),
                        ],
                      ),
                    );
              }),
            )

          ],
        ),
      ),
    );
  }
}
