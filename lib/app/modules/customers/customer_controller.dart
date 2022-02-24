import 'package:get/get.dart';
import '../../data/model/customer.dart';
import '../../data/repository/customer_repository.dart';

class CustomerController extends GetxController {
  final CustomerRepository customerRepository;

  CustomerController(this.customerRepository);

  final customerList = <Customer>[].obs;

  @override
  void onReady() async {
    super.onReady();
    getAllCustomers();
  }

  RxBool loading = false.obs;
  getAllCustomers() {
    customerRepository.getAllCustomers().then((data) {
      loading(true);
      customerList.value = data;
      loading(false);
    });
  }
}
