

enum SdkApiConstants {

  ORDER_DETAILS(value: 'Order details', route: '/payments/v1_2/orders/get'),
  MANDATE_DETAILS(value: 'Mandate order details', route: '/pgsi/v1_2/mandatetokens/get'),
  MODIFY_MANDATE_DETAILS(value: 'modify mandate order details', route: '/pgsi/v1_2/mandatetokens/get'),
  QUERY_WEB_DETAILS(value: "query web details", route: '/payments/v1_2/transactions/queryweb'),
  POLLING_DETAILS(value: "polling details", route: '/pgsi/v1_2/mandatetokens/poll');

  final String value;
  final String route;

  const SdkApiConstants({required this.value, required this.route});

}

