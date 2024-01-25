import 'package:dayday_flutter/src/controller/feed_controller.dart';
import 'package:dayday_flutter/src/screen/feed/create.dart';
import 'package:dayday_flutter/src/screen/feed/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

final feedController = Get.put(FeedController());

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  bool _visibility = true;

  Widget? showButton() {
    if (_visibility) {
      return InkWell(
          onTap: () {
            Get.to(() => const FeedCreate());
          },
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: Color(0xffD4A7FB),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ));
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    feedController.feedIndex(date);
  }

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  String date = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2024, 1, 31),
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                // print(focusedDay.toString());
                date = selectedDay.toString();
                feedController.feedIndex(date);
                _visibility = isSameDay(this.selectedDay, this.focusedDay);
              });
            },
            selectedDayPredicate: (DateTime day) {
              return isSameDay(selectedDay, day);
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color(0xffD4A7FB),
                shape: BoxShape.circle,
              ),
              todayTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Expanded(
            child: GetBuilder<FeedController>(
              builder: (controller) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    return FeedListItem(controller.list[index]);
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: showButton(),
    );
  }
}
