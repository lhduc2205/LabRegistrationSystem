import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/semester_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/share_components/schedule_table/schedule_table.dart';
import 'package:lab_registration_management/app/share_components/schedule_table/tab_bar.dart';

class ScheduleTableLayout extends StatelessWidget {
  const ScheduleTableLayout({
    Key? key,
    required this.tabController,
    required this.tabs,
    required this.onTap,
    required this.semesters,
    required this.scheduleTable,
    this.color,
  }) : super(key: key);

  final TabController tabController;
  final List<Widget> tabs;
  final Function(int)? onTap;
  final List<SemesterModel> semesters;
  final Widget scheduleTable;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: Border.all(
          color: kGrey,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: MyTabBar(
                  tabController: tabController,
                  tabs: tabs,
                  onTap: onTap,
                ),
              ),
              const Divider(
                height: 0,
                thickness: 0.25,
              ),
            ],
          ),
          Flexible(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(kSpacing),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: semesters
                      .map(
                        (_) => ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: scheduleTable
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
