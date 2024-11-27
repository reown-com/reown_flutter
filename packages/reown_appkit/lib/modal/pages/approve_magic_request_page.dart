import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class ApproveTransactionPage extends StatefulWidget {
  const ApproveTransactionPage()
      : super(key: KeyConstants.approveTransactionPage);

  @override
  State<ApproveTransactionPage> createState() => _ApproveTransactionPageState();
}

class _ApproveTransactionPageState extends State<ApproveTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return ModalNavbar(
      title: 'Approve Transaction',
      noClose: true,
      safeAreaLeft: true,
      safeAreaRight: true,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: ResponsiveData.maxHeightOf(context),
        ),
        child: GetIt.I<IMagicService>().webview,
      ),
    );
  }
}
