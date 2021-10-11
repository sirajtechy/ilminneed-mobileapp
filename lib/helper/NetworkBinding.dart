import 'package:get/get.dart';

import 'GetXNetworkManager.dart';

class NetworkBinding extends Bindings {
  // dependence injection attach our class.
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());
  }
}
