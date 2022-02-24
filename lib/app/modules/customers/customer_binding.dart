import 'package:agenda/app/data/provider/customer_provider.dart';
import 'package:agenda/app/modules/customers/customer_controller.dart';

import 'package:get/get.dart';

import '../../data/repository/customer_repository.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => CustomerController(CustomerRepository(CustomerProvider())));
  }
}
