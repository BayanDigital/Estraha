import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/support/ticket_details_controller.dart';
import 'package:booking_box/data/repo/support/support_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/screens/ticket/ticket_details_screen/sections/message_list_section.dart';
import 'package:booking_box/view/screens/ticket/ticket_details_screen/sections/reply_section.dart';
import 'package:booking_box/view/screens/ticket/ticket_details_screen/widget/ticket_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/warning_aleart_dialog.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  String title = "";
  @override
  void initState() {
    String ticketId = Get.arguments[0];
    title = Get.arguments[1];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportRepo(apiClient: Get.find()));
    var controller =
        Get.put(TicketDetailsController(repo: Get.find(), ticketId: ticketId));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketDetailsController>(
      builder: (controller) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(MyStrings.replyTicket.tr),
            actions: [
              if (controller.model.data?.myTickets?.status != '3')
                Padding(
                  padding: const EdgeInsets.only(right: Dimensions.space20),
                  child: TextButton(
                      onPressed: () {
                        const WarningAlertDialog().warningAlertDialog(
                            subtitleMessage:
                                MyStrings.youWantToCloseThisTicket.tr,
                            context, () {
                          Navigator.pop(context);
                          controller.closeTicket(
                              controller.model.data?.myTickets?.id.toString() ??
                                  '-1');
                        });
                      },
                      child: controller.closeLoading
                          ? Text(MyStrings.loading.tr,
                              style: regularMediumLarge.copyWith(
                                  color: MyColor.colorWhite))
                          : controller.isLoading
                              ? const SizedBox.shrink()
                              : Text(MyStrings.close.tr,
                                  style: regularMediumLarge.copyWith(
                                      color: MyColor.colorWhite))),
                )
            ],
          ),
          body: controller.isLoading
              ? const CustomLoader(isFullScreen: true)
              : SingleChildScrollView(
                  padding: Dimensions.screenPadding,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        TicketStatusWidget(controller: controller),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: MyColor.getCardBgColor(),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [ReplySection(), MessageListSection()],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }
}
