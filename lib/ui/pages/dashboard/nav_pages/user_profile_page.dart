import 'dart:io';
import 'package:ecomm_395/data/remote/model/order_model.dart';
import 'package:ecomm_395/domain/utils/app_constants.dart';
import 'package:ecomm_395/domain/utils/app_routes.dart';
import 'package:ecomm_395/domain/utils/theme_provider.dart';
import 'package:ecomm_395/data/firebase/firebase_options.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_bloc.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_event.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_state.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_bloc.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_event.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_state.dart';
import 'package:ecomm_395/ui/custom_widgets/order_card.dart';
import 'package:ecomm_395/ui/pages/order/order_detail_page.dart';
import 'package:ecomm_395/ui/pages/dashboard/nav_pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isDarkTheme = false;
  File? selectedImg;

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrderEvent());
    context.read<UserBloc>().add(FetchUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    isDarkTheme = context.watch<ThemeProvider>().isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) async {
              if (value == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              }

              if (value == 2) {
                // Logout logic
                SharedPreferences? prefs =
                    await SharedPreferences.getInstance();
                // prefs.remove(AppConstants.prefUserIdKey);
                Navigator.pushReplacementNamed(context, AppRoutes.signin);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Logged out !"),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<int>(
                value: 1,
                enabled: false, // disable default tap
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDarkTheme
                        ? Text(
                            "Dark Theme",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            "Dark Theme",
                            style: TextStyle(color: Colors.black),
                          ),
                    Switch(
                      value: isDarkTheme,
                      onChanged: (val) {
                        context.read<ThemeProvider>().isDarkTheme = val;
                        Navigator.pop(context); // close popup
                      },
                    ),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Text("Logout"),
                    SizedBox(width: 10),
                    Icon(Icons.logout, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: [
                    Text("Settings"),
                    SizedBox(width: 10),
                    Icon(Icons.settings),
                  ],
                ),
              ),
            ],
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("User Profile")],
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
                    leading: InkWell(
                      onTap: () async {
                        XFile? pickedImg = await ImagePicker().pickImage(
                          source: ImageSource.camera,
                        );
                        if (pickedImg != null) {
                          CroppedFile?
                          croppedFile = await ImageCropper().cropImage(
                            sourcePath: pickedImg.path,
                            uiSettings: [
                              AndroidUiSettings(
                                lockAspectRatio: true,
                                initAspectRatio: CropAspectRatioPreset.square,
                                cropStyle: CropStyle.circle,
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.square,
                                ],
                              ),
                              IOSUiSettings(
                                aspectRatioLockEnabled: true,
                                // aspectRatioPresets: [CropAspectRatioPreset.square],
                                cropStyle: CropStyle.circle,
                                showCancelConfirmationDialog: true,
                              ),
                              WebUiSettings(context: context),
                            ],
                          );
                          if (croppedFile != null) {
                            selectedImg = File(croppedFile.path);

                            setState(() {});
                          }

                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: selectedImg != null
                              ? DecorationImage(
                                  image: FileImage(selectedImg!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.orange, width: 2),
                        ),
                      ),
                    ),

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
