import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MobileCalendarScreen extends StatefulWidget {
  const MobileCalendarScreen({Key? key}) : super(key: key);
  static const String routeName = '/mobile_calendar';

  @override
  State<MobileCalendarScreen> createState() => _MobileCalendarScreenState();
}

class _MobileCalendarScreenState extends State<MobileCalendarScreen> {
  DateTime _currentDate = DateTime.now();
  bool isExpanded = false;

  final Map<String, String> holidayImages = {
    '2025-12-25': 'assets/images/christmas.png',
    '2025-01-01': 'assets/images/new_year.png',
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    if (!isMobile && !isTablet) {
      Future.microtask(() => Get.offAllNamed('/overview'));
      return const SizedBox();
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //   colors: [Colors.blue.shade900, Colors.blue.shade300],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: size.width,
                height: isExpanded ? 700 : 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.blue.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              Future.microtask(
                                () => Get.offAllNamed('/overview'),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 16,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Back",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: CalendarCarousel<Event>(
                            onDayPressed: (DateTime date, List<Event> events) {
                              setState(() => _currentDate = date);

                              String formattedDate =
                                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                              String? imagePath = holidayImages[formattedDate];

                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                builder:
                                    (context) => SizedBox(
                                      height: size.height * 1.2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            if (imagePath != null)
                                              Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      imagePath,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              )
                                            else
                                              const Icon(
                                                Icons.calendar_today,
                                                size: 100,
                                                color: Colors.grey,
                                              ),
                                            const SizedBox(height: 16),
                                            Text(
                                              "Selected Date: ${_currentDate.day}-${_currentDate.month}-${_currentDate.year}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              imagePath != null
                                                  ? "Holiday!"
                                                  : "No holiday",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    imagePath != null
                                                        ? Colors.green
                                                        : Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              );
                            },
                            weekendTextStyle: const TextStyle(
                              color: Colors.red,
                            ),
                            thisMonthDayBorderColor: Colors.grey,
                            selectedDayButtonColor: Colors.blue.shade900,
                            selectedDayTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            todayButtonColor: Colors.black,
                            todayTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            showOnlyCurrentMonthDate: true,
                            weekdayTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            selectedDateTime: _currentDate,
                          ),
                        ),
                      ],
                    ),

                    // Divider / toggle
                    Positioned(
                      bottom: 0,
                      left: size.width * 0.4,
                      right: size.width * 0.4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Decorative circle
          Positioned(
            top: -30,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
