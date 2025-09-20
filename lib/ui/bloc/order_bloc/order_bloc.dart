import 'package:ecomm_395/data/remote/model/order_model.dart';
import 'package:ecomm_395/data/remote/repository/order_repo.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_event.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{

  OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}): super(OrderInitialState()){

    on<GetOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      try{

        dynamic res = await orderRepository.getAllOrders();
        if(res["status"]){
          List<OrderItemsModel> allOrders = OrderDataModel.fromJson(res).orderItemsModel ?? [];
          emit(OrderSuccessState(allordersData: allOrders));
        }else{
          OrderFailureState(errorMsg: res["message"]);
        }


      }catch(e){
        emit(OrderFailureState(errorMsg: e.toString()));
      }

    });

  }

}