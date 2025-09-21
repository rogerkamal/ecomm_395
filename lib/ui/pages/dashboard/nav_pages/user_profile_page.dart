import 'package:camera/camera.dart';
import 'package:ecomm_395/data/remote/model/order_model.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_bloc.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_event.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_state.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_bloc.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_event.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_state.dart';
import 'package:ecomm_395/ui/custom_widgets/order_card.dart';
import 'package:ecomm_395/ui/pages/order/order_detail_page.dart';
import 'package:ecomm_395/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    context.read<OrderBloc>().add(GetOrderEvent());
    context.read<UserBloc>().add(FetchUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*InkWell(
              onTap: (){
                Navigator.pop(context);
              },

              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back_ios_sharp, color: Colors.black, size: 20),
              ),
            ),*/
            Text("User Profile"),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.signin);
              },
              child: Icon(
                Icons.logout,
                fontWeight: FontWeight.bold,
                size: 35,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  );
                }
                if (state is UserFailureState) {
                  return Center(child: Text(state.errorMsg));
                }
                if (state is UserProfileLoadedState) {
                  return ListTile(
                    leading: ClipOval(child: Icon(Icons.camera_alt)),

                    title: Text(state.userProfileData!.name!),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.userProfileData!.email!),
                        Text(state.userProfileData!.mobileNumber!),
                      ],
                    ),
                  );
                }

                return Container();
              },
            ),

            Padding(
              padding: EdgeInsets.only(left: 55, top: 10, bottom: 10),
              child: Text(
                "My All Orders:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoadingState) {
                    Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }
                  if (state is OrderFailureState) {
                    return Center(child: Text(state.errorMsg));
                  }
                  if (state is OrderSuccessState) {
                    return state.allordersData.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.allordersData.length,
                            itemBuilder: (_, index) {
                              OrderItemsModel eachOrder =
                                  state.allordersData[index];
                              return OrderCard(
                                currentOrder: eachOrder,
                                indexInt: index,
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetailPage(
                                        currentOrder: eachOrder,
                                      ),
                                    ),
                                  );
                                },
                              );
                              /*ListTile(
                          leading: Text("${index + 1}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          title: Text("Order Number# :${eachOrder.orderNumber!}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Amount: \$${eachOrder.totalAmount!}",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Date :${eachOrder.createdAt!}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        );*/
                            },
                          )
                        : Center(child: Text("No Orders Yet"));
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
