// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:elagk_deivery/Models/HomePage/all_orders_model.dart';
import 'package:elagk_deivery/Models/HomePage/one_order_model.dart';
import 'package:elagk_deivery/Models/orders/end_order_model.dart';
import 'package:elagk_deivery/Modules/Auth/login_screen.dart';
import 'package:elagk_deivery/Modules/DrawerScreen/complaints.dart';
import 'package:elagk_deivery/Shared/navigation/navigate_to.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '/Cubit/states.dart';
import '../Models/AppData/about_contact_us_model.dart';
import '../Models/auth/login_model.dart';
import '../Models/auth/profile_data.dart';
import '../Models/orders/start_order_model.dart';
import '../Modules/DrawerScreen/about_us.dart';
import '../Modules/DrawerScreen/contact_us.dart';
import '../Modules/DrawerScreen/profile_data.dart';
import '../Modules/HomePage/orders.dart';
import '../Network/global/http_helper.dart';
import '../Network/local/cache_helper.dart';
import '../Shared/Drawer/home_drawer.dart';
import '../Shared/Drawer/menu_item.dart';
import '../Shared/Drawer/menu_screens.dart';
import '../Shared/image_widgets/asset_image.dart';
import '../Shared/navigation/navigate_final_to.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  String api = "https://elagkapp.com/api/v1/";

  bool isLoadingAuth = false;

  void loadingScreens(bool value) {
    isLoadingAuth = value;
    emit(HomeLoadingScreensState());
  }

  LoginModel? loginModel;

  Future<void> login(
      {required String password,
      required String email,
      required BuildContext context}) async {
    loadingScreens(true);
    emit(HomeLoginLoadingState());
    var deviceToken = await FirebaseMessaging.instance.getToken();
    await http.post(Uri.parse('${api}delivery/login'), body: {
      'email': email,
      'password': password,
      'device_token': deviceToken
    }, headers: {
      'Accept': 'application/json'
    }).then((value) {
      loginModel = LoginModel.fromJson(jsonDecode(value.body));
      if (loginModel!.code == 200) {
        var token = loginModel!.data!.token.toString();
        CacheHelper.putData(key: "token", value: token);
        loadingScreens(false);
        getAboutUs();
        navigateFinalTo(context, const HomeDrawer());
      } else {
        loadingScreens(false);
        Fluttertoast.showToast(msg: "Email or password is incorrect");
      }
      emit(HomeRegisterSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("login error is $e");
      }
      Fluttertoast.showToast(
          msg: "there is a something wrong, Try Again Later");
      loadingScreens(false);
      emit(HomeRegisterErrorState());
    });
  }

  getScreen(MyMenuItem currentItem) {
    switch (currentItem) {
      case MenuItems.homepage:
        return AllOrders();
      case MenuItems.profile:
        return const ProfileData();
      case MenuItems.contactUs:
        return const ContactUsScreen();
      case MenuItems.aboutUs:
        return const AboutUsScreen();
      case MenuItems.complaints:
        return ComplaintsScreen();
    }
  }

  AboutUsModel? aboutUsModel;

  Future getAboutUs() async {
    emit(HomeGetAboutUsLoadingState());
    await HttpHelper.getData('about_us').then((value) {
      aboutUsModel = AboutUsModel.fromJson(value);
      if (CacheHelper.getData(key: "token") != null) {
        getAllOrders();
        getProfileData();
      }
      emit(HomeGetAboutUsSuccessState());
    }).catchError((e) {
      debugPrint("getAboutUs error is : $e");
      emit(HomeGetAboutUsErrorState());
    });
  }

  launchMap({required String lat, required String lng}) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(urlAppleMaps)) {
      await launch(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }

  void whatsAppOpen(String number) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+2$number/?text=${Uri.encodeFull("مرحبَا، هل يمكنك إخباري بمواعيد العمل الخاصة بك؟")}";
      } else {
        return "whatsapp://send?phone=+2$number&text=${Uri.encodeFull("مرحبَا، هل يمكنك إخباري بمواعيد العمل الخاصة بك؟")}";
      }
    }

    launchUrl(Uri.parse(url()));
  }

  sendingMails(String url) async {
    url = 'mailto:feedback@$url';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchInstagram(String? username, String profileLink) async {
    String nativeUrl = "instagram://user?username=$username";
    String webUrl = profileLink;
    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      if (kDebugMode) {
        print("can't open Instagram");
      }
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void openFaceBook(String pageLink) async {
    var url = 'fb://facewebmodal/f?href=$pageLink';
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  AllOrdersModel? allOrdersModel;

  Future<void> getAllOrders() async {
    emit(AllordersLoadingState());
    var uri = Uri.parse("${api}delivery/orders");
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "token")}'
    };
    await http.get(uri, headers: header).then((value) {
      allOrdersModel = AllOrdersModel.fromJson(jsonDecode(value.body));
      allOrdersModel!.data!
          .sort(((b, a) => a.createdAt!.compareTo(b.createdAt!)));
      print(allOrdersModel);
      print(value.body);
      emit(AllordersSuccessState());
    }).catchError((error) {
      debugPrint("getAllOrders error is : $error");
      emit(AllordersErrorState());
    });
  }

  OneOrdersModel? oneOrdersModel;

  Future<void> getOneOrders(String id) async {
    emit(AllordersLoadingState());
    var uri = Uri.parse("${api}delivery/orders/$id");
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "token")}'
    };
    await http.get(uri, headers: header).then((value) {
      oneOrdersModel = OneOrdersModel.fromJson(jsonDecode(value.body));
      emit(AllordersSuccessState());
    }).catchError((error) {
      debugPrint("getOneOrders error is : $error");
      emit(AllordersErrorState());
    });
  }

  StartOrderModel? startOrderModel;

  Future<void> startOrder(String id, BuildContext context) async {
    emit(AllordersLoadingState());
    var uri = Uri.parse("${api}delivery/start-order/$id");
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "token")}'
    };
    await http.post(uri, headers: header).then((value) {
      startOrderModel = StartOrderModel.fromJson(jsonDecode(value.body));
      Fluttertoast.showToast(msg: startOrderModel!.msg.toString());
      navigateTo(context, AllOrders());
      emit(AllordersSuccessState());
    }).catchError((error) {
      debugPrint("startOrder error is : $error");
      emit(AllordersErrorState());
    });
  }

  EndOrderModel? endOrderModel;

  Future<void> endOrder(String id, BuildContext context) async {
    emit(AllordersLoadingState());
    var uri = Uri.parse("${api}delivery/end-order/$id");
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "token")}'
    };
    await http.post(uri, headers: header).then((value) {
      endOrderModel = EndOrderModel.fromJson(jsonDecode(value.body));
      Fluttertoast.showToast(msg: endOrderModel!.msg.toString());
      navigateTo(context, AllOrders());
      emit(AllordersSuccessState());
    }).catchError((error) {
      debugPrint("startOrder error is : $error");
      emit(AllordersErrorState());
    });
  }

  Future<void> logOutAccount(BuildContext context) async {
    emit(HomeGetCitiesLoadingState());
    var uri = Uri.parse('${api}client/logout');
    await http.post(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      if (kDebugMode) {
        print(jsonDecode(value.body));
      }
      CacheHelper.deleteData(key: 'token');
      Fluttertoast.showToast(msg: "تم تسجيل الخروج بنجاح");
      navigateFinalTo(context, LoginScreen());
      emit(HomeGetCitiesSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("logOutAccount error is $e");
      }
      Fluttertoast.showToast(msg: '$e');
      emit(HomeGetCitiesErrorState());
    });
  }

  Future contactUS(
      {required String body,
      required String title,
      required BuildContext context}) async {
    loadingScreens(true);
    emit(HomeRegisterLoadingState());
    await http.post(Uri.parse('${api}contact-us'), body: {
      'email': myProfileModel!.data!.email.toString(),
      'name': myProfileModel!.data!.name.toString(),
      'phone': myProfileModel!.data!.phone.toString(),
      'body': body,
      'title': title
    }, headers: {
      'Accept': 'application/json'
    }).then((value) {
      if (jsonDecode(value.body)['code'] == 201) {
        loadingScreens(false);
        Fluttertoast.showToast(msg: jsonDecode(value.body)['msg'].toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        myImage('assets/images/newlogo/3elagk WORD.png'),
                        const Text("شكرا لك يسعادنا دائما انك معانا",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              );
            });

        emit(HomeRegisterSuccessState());
      } else {
        loadingScreens(false);
        Fluttertoast.showToast(msg: "برجاء ملئ جميع الحقول المطلوبة");
        emit(HomeRegisterErrorState());
      }
    }).catchError((e) {
      loadingScreens(false);
      Fluttertoast.showToast(msg: "يرجي المحاولة في وقت لاحق");
      debugPrint("contactUS error is $e");
      emit(HomeRegisterErrorState());
    });
  }

  MyProfileModel? myProfileModel;

  Future<void> getProfileData() async {
    emit(HomeRegisterLoadingState());
    await http.get(Uri.parse('${api}profile/client'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      myProfileModel = MyProfileModel.fromJson(jsonDecode(value.body));
      if (kDebugMode) {
        print("myProfile Data is $myProfileModel");
      }
      if (kDebugMode) {
        print("myProfile value.body ${value.body}");
      }
      emit(HomeRegisterSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("getProfileData error is $e");
      }
      emit(HomeRegisterErrorState());
    });
  }
}
