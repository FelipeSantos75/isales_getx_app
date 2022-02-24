import 'package:agenda/app/modules/customers/customer_controller.dart';
import 'package:agenda/data/provider/json_to_widget.dart';
import 'package:agenda/app/data/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomerCard extends GetView<CustomerController> {
  const CustomerCard({Key? key, required this.customer}) : super(key: key);
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    // final mWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final double mHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      mHeight = MediaQuery.of(context).size.height * .95;
    } else {
      mHeight = MediaQuery.of(context).size.width;
    }
    return showFutureBuilder(context);
    // return customer.layoutpage!;
  }

  FutureBuilder<Widget> showFutureBuilder(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<JsonToWidget>(context).loadWidgetList(customer, context),
      builder: (BuildContext context, AsyncSnapshot snapshotLayout) {
        if (snapshotLayout.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshotLayout.error != null) {
          print(snapshotLayout.data);
          return const Center(
            child: Text(
                'Ocorreu um erro ao carregar, certifique que está conectado a internet'),
          );
        } else {
          return snapshotLayout.data;
        }
      },
    );
  }
}


// class CustomerCardStatic extends StatelessWidget {
//   const CustomerCardStatic({Key? key, required this.customer}) : super(key: key);
//   final Customer customer;

//   @override
//   Widget build(BuildContext context) {
//     final mWidth = MediaQuery.of(context).size.width;
//     final double mHeight;
//     if (MediaQuery.of(context).orientation == Orientation.portrait) {
//       mHeight = MediaQuery.of(context).size.height * .95;
//     } else {
//       mHeight = MediaQuery.of(context).size.width;
//     }
//     return Container(
//       height: mHeight * .09,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(
//               bottom: BorderSide(width: 1, color: Colors.grey.shade200))),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 5, right: 5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     customer.name!.toUpperCase(),
//                     maxLines: 1,
//                     style: TextStyle(
//                       fontSize: mHeight * .022,
//                       // overflow: TextOverflow.fade,
//                       fontWeight: FontWeight.bold,

//                       color: Color(int.parse(layout['myTextColor'])),
//                     ),
//                   ),
//                   Text(
//                     customer.address!,
//                     maxLines: 2,
//                     style: TextStyle(
//                       fontSize: mHeight * .02,
//                       color: Colors.grey,
//                       overflow: TextOverflow.fade,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 5, right: 5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     customer.email!.toLowerCase(),
//                     maxLines: 1,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       // overflow: TextOverflow.fade,
//                       fontWeight: FontWeight.bold,
//                       color: Color(int.parse(layout['myTextColor'])),
//                     ),
//                   ),
//                   Text(
//                     customer.phone!,
//                     maxLines: 2,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                       overflow: TextOverflow.fade,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }