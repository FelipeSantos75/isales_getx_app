import 'package:agenda/app/data/provider/customer_provider.dart';
import 'package:agenda/app/data/repository/customer_repository.dart';
import 'package:agenda/app/modules/customers/customer_controller.dart';

import 'package:agenda/data/provider/json_to_widget.dart';

import 'package:agenda/screens/customer/customer_details.dart';
import 'package:agenda/components/mycolors.dart' as c;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'local_widgets/customer_card.dart';

class CustomerList extends GetView<CustomerController> {
  @override
  final controller = Get.find<CustomerController>().;
  CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final mWidth = MediaQuery.of(context).size.width;
    final double mHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      mHeight = MediaQuery.of(context).size.height;
    } else {
      mHeight = MediaQuery.of(context).size.width;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: c.myTextColor,
          foregroundColor: c.myPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.arrow_back),
          ),
          bottom: PreferredSize(
              child: Container(
                color: c.myPrimaryColor,
                height: mHeight * .005,
              ),
              preferredSize: const Size.fromHeight(8.0)),
          title: const Text(
            'iSales Clientes',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _showHeader(context),
            Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? mHeight * .7 - 10
                  : mHeight * .6 - 190,
              child: ListView.builder(
                itemCount: controller.customerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CustomerDetails(
                            customer: controller.customerList[index],
                          ),
                        ),
                      );
                    },
                    child: CustomerCard(
                      customer: controller.customerList[index],
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

  // Container _showListOfCustomers(
  //     BuildContext context, double mHeight, AsyncSnapshot<dynamic> snapshot) {
  //   return ;
  // }

  FutureBuilder<Widget> _showHeader(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<JsonToWidget>(context).loadWidgetListTitle(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          // print(snapshot.data);
          return const Center(
            child: Text(
                'Ocorreu um erro ao carregar, certifique que está conectado a internet'),
          );
        } else {
          return snapshot.data;
        }
      },
    );
  }
}
