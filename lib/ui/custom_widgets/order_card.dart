import 'package:ecomm_395/data/remote/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  OrderItemsModel currentOrder;
  int indexInt;
  VoidCallback onPress;

  OrderCard({required this.currentOrder,required this.indexInt,required this.onPress});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPress,
        child: ListTile(
          leading: Text("${widget.indexInt + 1}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          title: Text("Order Number# :${widget.currentOrder.orderNumber!}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Amount: \$${widget.currentOrder.totalAmount!}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                "Date :${widget.currentOrder.createdAt!}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );

  }
}
