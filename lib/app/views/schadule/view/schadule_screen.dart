import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../Routes/app_pages.dart';
import '../controller/schadule_controller.dart';
import '../models/schadule_model.dart';
import '../../../widget/custom_floating_actions.dart';

class SchaduleScreen extends GetView<SchaduleController> {
  const SchaduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Set the length of your TabController here
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildTabBarView(),
        floatingActionButton: CustomFloatingActionBotton(
          onTap: () => Get.toNamed(Routes.addNewSchaduleScreen),
          hero: 'schadule',
        ),
      ),
    );
  }

  PreferredSize _buildTabBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(5),
      child: TabBar(
        labelStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w600),
        labelColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        tabs: const <Widget>[
          Tab(text: 'شهر'),
          Tab(text: 'يوم'),
        ],
      ),
    );
  }

  TabBarView buildTabBarView() {
    return TabBarView(
      children: [
        buildCalendarPage(CalendarView.month),
        buildCalendarPage(CalendarView.day),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 8.0,
      bottom: _buildTabBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
    );
  }

  Widget buildCalendarPage(CalendarView view) {
    return SfCalendar(
      showDatePickerButton: true,
      view: view,
      scheduleViewMonthHeaderBuilder:
          (BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
        return Container(
          color: Theme.of(Get.context!).colorScheme.secondaryContainer,
          child: Center(
            child: Text(
              '${details.date.month} ,${details.date.year}',
            ),
          ),
        );
      },

      monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
      showNavigationArrow: true,
      showCurrentTimeIndicator: true,
      showTodayButton: true,
      scheduleViewSettings: ScheduleViewSettings(
        monthHeaderSettings: MonthHeaderSettings(
          monthFormat: 'MMMM, yyyy',
          height: 60,
          monthTextStyle: Theme.of(Get.context!).textTheme.bodyLarge,
          textAlign: TextAlign.center,
          backgroundColor:
              Theme.of(Get.context!).colorScheme.secondaryContainer,
        ),
        appointmentTextStyle: Theme.of(Get.context!)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
      dataSource: MeetingDataSource(
        controller.meetings,
      ), // Use the controller data
    );
  }
}
