import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:enefty_icons/enefty_icons.dart';

class CalendarDropdown extends StatefulWidget {
  final void Function(DateTime)? onSelected;

  const CalendarDropdown({super.key, this.onSelected});

  @override
  State<CalendarDropdown> createState() => _CalendarDropdownState();
}

class _CalendarDropdownState extends State<CalendarDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  final Map<String, String> _holidayImages = {
    '2025-12-25': 'assets/images/christmas.png',
    '2025-01-01': 'assets/images/new_year.png',
  };

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  bool get isDesktop {
    final width = MediaQuery.of(context).size.width;
    return width >= 1024;
  }

  void _toggle() {
    if (!isDesktop) return;

    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _overlay();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() => _isOpen = !_isOpen);
  }

  OverlayEntry _overlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    return OverlayEntry(
      builder: (_) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _toggle,
                child: Container(),
              ),
            ),

            Positioned(
              left: offset.dx + size.width - 320,
              top: offset.dy + size.height + 6,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xFF242C40)),
                  width: 320,
                  padding: const EdgeInsets.all(8),
                  child: TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: _selectedDate,
                    selectedDayPredicate:
                        (day) => isSameDay(day, _selectedDate),
                    onDaySelected: (selected, focused) {
                      setState(() {
                        _selectedDate = selected;
                        _focusedDate = focused;
                      });

                      widget.onSelected?.call(selected);
                      _toggle();

                      final key = DateFormat('yyyy-MM-dd').format(selected);
                      final holidayImage = _holidayImages[key];
                      if (holidayImage != null) {
                        showModalBottomSheet(
                          context: context,
                          builder:
                              (_) => Container(
                                padding: const EdgeInsets.all(16),
                                height: 500,
                                width: 800,
                                child: Column(
                                  children: [
                                    Text(
                                      "Holiday!",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Image.asset(
                                        holidayImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        );
                      }
                    },
                    weekendDays: [DateTime.sunday],
                    calendarFormat: CalendarFormat.month,
                    headerStyle: HeaderStyle(
                      titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      titleCentered: true,
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      formatButtonVisible: false,
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        shape: BoxShape.circle,
                      ),
                      weekendTextStyle: const TextStyle(
                        color: Colors.redAccent,
                      ),
                      defaultTextStyle: const TextStyle(color: Colors.white),
                      todayTextStyle: const TextStyle(color: Colors.white),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) return const SizedBox.shrink();

    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        icon: const Icon(EneftyIcons.calendar_2_bold, color: Colors.blue),
        iconSize: 26,
        onPressed: _toggle,
      ),
    );
  }
}
