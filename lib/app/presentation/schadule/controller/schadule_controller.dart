import 'package:salesman/app/service/database/customer_database.dart';
import 'package:salesman/app/service/database/leads_database.dart';
import 'package:salesman/app/service/database/lost_customer_database.dart';
import 'package:salesman/app/service/database/meeting_db.dart';
import 'package:salesman/app/helper/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../service/database/abstract_database_class.dart';
import '../../contacts/model/contact_info_model.dart';
import '../models/schadule_model.dart';

class SchaduleController extends GetxController {
  SchaduleController get instance => Get.find();
  final RxList<ContactInfoModel> contacts = <ContactInfoModel>[].obs;
  final TextEditingController contactController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController timeToController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final MeetingDB meetingDB = MeetingDB();
  Rx<CalendarView> calendarView = CalendarView.timelineDay.obs;
  late MeetingDataSource dataSource;
  Rx<ContactInfoModel?> selectedContact = Rx<ContactInfoModel?>(null);
  RxList<Meeting> meetings = <Meeting>[].obs;
  DateTime meetingDate = DateTime.now();
  DateTime meetingTime = DateTime.now();
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();
  PageController pageController = PageController();
  @override
  void onInit() {
    fetchMeetingsFromDB();
    fetchContacts();
    meetings.assignAll(getInitialDataSource());
    logError(meetings.length.toString());
    dataSource = MeetingDataSource(meetings);
    super.onInit();
  }

  @override
  void onClose() {
    meetingDB.closeDatabase();
    super.onClose();
  }

  void changePage() {
    int nextPage = pageController.page!.toInt() + 1;
    if (nextPage < 2) {
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      pageController.jumpToPage(0);
    }
  }

  Future<void> fetchContacts() async {
    contacts.clear();
    await getAllContacts();
  }

  Future<void> fetchMeetingsFromDB() async {
    await meetingDB.initDatabase();
    meetings.assignAll(await meetingDB.getAllMeetings());
    update();
  }

  Future<void> saveMeetingInDB(Meeting meet) async {
    await meetingDB.insertMeeting(meet);
  }

  Future<void> getAllContacts() async {
    final LeadsDatabase lDB = LeadsDatabase();
    final CustomersDatabase cDB = CustomersDatabase();
    final LostedCustomersDatabase losDB = LostedCustomersDatabase();
    await _fetchContactsFromDatabase(lDB);
    await _fetchContactsFromDatabase(cDB);
    await _fetchContactsFromDatabase(losDB);
    contacts.refresh();
  }

  Future<void> _fetchContactsFromDatabase(DatabaseModule database) async {
    final List<ContactInfoModel> databaseContacts =
        await database.getAllContacts();
    contacts.addAll(databaseContacts);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      dateController.text = formattedDate;
      meetingDate = pickedDate;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      fromTime = pickedTime;
      final formattedTime = "${pickedTime.hour}:${pickedTime.minute}";
      timeController.text = formattedTime;
    }
  }

  Future<void> selectToTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      toTime = pickedTime;
      final formattedTime = "${pickedTime.hour}:${pickedTime.minute}";
      timeToController.text = formattedTime;
    }
  }

  void addNewMeeting() {
    final DateTime d = meetingDate;
    final TimeOfDay t = fromTime;
    final TimeOfDay end = toTime;
    final DateTime startTime =
        DateTime(d.year, d.month, d.day, t.hour, t.minute, 0);
    final DateTime endTime =
        DateTime(d.year, d.month, d.day, end.hour, end.minute, 0);
    final newMeeting = Meeting(
      descriptionController.text,
      startTime,
      endTime,
      Theme.of(Get.context!).colorScheme.primary,
      false,
    );
    saveMeetingInDB(newMeeting);
    dataSource.appointments!.add(newMeeting);
    dataSource.notifyListeners(CalendarDataSourceAction.add, [newMeeting]);
    fetchMeetingsFromDB();
  }

  List<Meeting> getInitialDataSource() {
    return [];
  }

  void changeCalendarView(calendarTapDetails) {
    calendarView = CalendarView.timelineDay.obs;
    update();
  }
}
