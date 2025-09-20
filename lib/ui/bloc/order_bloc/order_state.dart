import 'package:ecomm_395/data/remote/model/order_model.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderState{}

class OrderInitialState extends OrderState{}
class OrderLoadingState extends OrderState{}
class OrderFailureState extends OrderState{
  String errorMsg;
  OrderFailureState({required this.errorMsg});
}
class OrderSuccessState extends OrderState{
  List<OrderItemsModel> allordersData;

  OrderSuccessState({required this.allordersData});

}