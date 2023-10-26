import 'package:fbazaar_admin/controllers/ordercontroller.dart';
import 'package:fbazaar_admin/controllers/profilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../statics/appcolors.dart';

class AssignDriver extends StatefulWidget {
  final name;
  final id;
  final token;
  final cartId;
  final quantity;
  final price;
  final category;
  final size;
  final paymentMethod;
  final dropOffLat;
  final dropOffLng;
  final deliveryMethod;
  final unCode;
  const AssignDriver(
      {super.key,
      required this.name,
      required this.id,
      required this.token,
      required this.cartId,
      required this.quantity,
      required this.price,
      required this.category,
      required this.size,
      required this.paymentMethod,
      required this.dropOffLat,
      required this.dropOffLng,
      required this.deliveryMethod,
      required this.unCode});

  @override
  State<AssignDriver> createState() => _AssignDriverState(
      name: this.name,
      id: this.id,
      token: this.token,
      cartId: this.cartId,
      quantity: this.quantity,
      price: this.price,
      category: this.category,
      size: this.size,
      paymentMethod: this.paymentMethod,
      dropOffLat: this.dropOffLat,
      dropOffLng: this.dropOffLng,
      deliveryMethod: this.deliveryMethod,
      unCode: this.unCode);
}

class _AssignDriverState extends State<AssignDriver> {
  final name;
  final id;
  final token;
  final cartId;
  final quantity;
  final price;
  final category;
  final size;
  final paymentMethod;
  final dropOffLat;
  final dropOffLng;
  final deliveryMethod;
  final unCode;
  _AssignDriverState(
      {required this.name,
      required this.id,
      required this.token,
      required this.cartId,
      required this.quantity,
      required this.price,
      required this.category,
      required this.size,
      required this.paymentMethod,
      required this.dropOffLat,
      required this.dropOffLng,
      required this.deliveryMethod,
      required this.unCode});
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Assign Driver to $name"),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  color: defaultTextColor2),
            )),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            return ListView.builder(
                itemCount: controller.allDrivers != null
                    ? controller.allDrivers.length
                    : 0,
                itemBuilder: (context, index) {
                  items = controller.allDrivers[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/driver.png"),
                                  radius: 30),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(items['username'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                              const SizedBox(height: 10),
                              GetBuilder<OrderController>(
                                  builder: (orderController) {
                                return RawMaterialButton(
                                  fillColor: newButton,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                    Get.snackbar(
                                      "Pleaser Wait",
                                      "Assigning Driver to Order",
                                      duration: const Duration(seconds: 5),
                                      colorText: defaultTextColor1,
                                      backgroundColor: newDefault,
                                    );
                                    orderController.assignDriverToOrder(
                                        id,
                                        token,
                                        cartId,
                                        quantity,
                                        price,
                                        category,
                                        size,
                                        paymentMethod,
                                        dropOffLat,
                                        dropOffLng,
                                        deliveryMethod,
                                        unCode,
                                        controller.allDrivers[index]['id']
                                            .toString());
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Assign Driver",
                                        style: TextStyle(
                                            color: defaultTextColor1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ),
                                );
                              })
                            ],
                          ),
                        )),
                  );
                });
          },
        ));
  }
}
