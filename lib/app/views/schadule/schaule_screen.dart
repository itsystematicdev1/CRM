import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../routes/app_pages.dart';
import '../../controllers/schadule/schadule_controller.dart';
import '../../models/schadule_model.dart';
import '../../widget/custom_appbar.dart';

class SchaduleScreen extends GetView<SchaduleController> {
  const SchaduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: '', isBackButtonExist: false),
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'شهر'),
                Tab(text: 'اليوم'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildCalendarPage(CalendarView.month),
                  buildCalendarPage(CalendarView.schedule),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.addNewSchaduleScreen),
        child: const Icon(Icons.add),
      ),
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
