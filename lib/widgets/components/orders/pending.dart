import 'package:fbazaar_admin/controllers/ordercontroller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../statics/appcolors.dart';
import 'assigndriver.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({super.key});

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  final OrderController orderController = Get.find();
  var items;

  final storage = GetStorage();
  late String uToken = "";

  @override
  void initState() {
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Pending Orders"),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  color: defaultTextColor2),
            )),
        body: GetBuilder<OrderController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.pendingOrders != null
                  ? controller.pendingOrders.length
                  : 0,
              itemBuilder: (context, index) {
                items = controller.pendingOrders[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: items['get_item_pic'] == ""
                                  ? Image.asset("assets/images/fbazaar.png",
                                      width: 100, height: 100)
                                  : Image.network(items['get_item_pic'],
                                      width: 100, height: 100),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(items['get_username'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text(items['get_item_name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text(
                                      items['date_order_created']
                                          .toString()
                                          .split("T")
                                          .first,
                                      style: const TextStyle(
                                          color: muted,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text("₵ ${items['get_item_price']}",
                                      style: const TextStyle(
                                          color: primaryYellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text("Qty : ${items['quantity']}",
                                      style: const TextStyle(
                                          color: primaryYellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text("DM: ${items['delivery_method']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const Divider(
                                      height: 10, color: Colors.blueGrey),
                                  Text("PM: ${items['payment_method']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const SizedBox(height: 10),
                                  RawMaterialButton(
                                    fillColor: newButton,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    onPressed: () {
                                      Get.to(() => AssignDriver(
                                          name: controller.pendingOrders[index]
                                              ['get_item_name'],
                                          id: controller.pendingOrders[index]['id']
                                              .toString(),
                                          token: uToken,
                                          cartId: controller
                                              .pendingOrders[index]['cart']
                                              .toString(),
                                          quantity: controller
                                              .pendingOrders[index]['quantity']
                                              .toString(),
                                          price: controller.pendingOrders[index]
                                                  ['price']
                                              .toString(),
                                          category: controller
                                              .pendingOrders[index]['category'],
                                          size: controller.pendingOrders[index]['size'].toString(),
                                          paymentMethod: controller.pendingOrders[index]['payment_method'],
                                          dropOffLat: controller.pendingOrders[index]['drop_off_location_lat'],
                                          dropOffLng: controller.pendingOrders[index]['drop_off_location_lng'],
                                          deliveryMethod: controller.pendingOrders[index]['delivery_method'],
                                          unCode: controller.pendingOrders[index]['unique_order_code']));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Assign Driver",
                                          style: TextStyle(
                                              color: defaultTextColor1,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}
