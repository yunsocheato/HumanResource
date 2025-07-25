import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/controllers/drawer_controller.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../widgets/department_piechart.dart';

class DepartmentScreen extends StatefulWidget {
  static const String routeName = '/DepartmentScreen';

  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen>
    with TickerProviderStateMixin {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  bool _showLoginCard = false;
  bool _showLoginCard1 = false;

  String? _error;
  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<AppDrawerController>()) {
      Get.put(AppDrawerController());
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLoginCard = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLoginCard1 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawerscreen(
      content: Scrollbar(
        thumbVisibility: true,
        controller: _verticalScrollController,
        child: SingleChildScrollView(
          controller: _verticalScrollController,
          scrollDirection: Axis.vertical,
          child: Scrollbar(
            thumbVisibility: true,
            controller: _horizontalScrollController,
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                stepWidth: MediaQuery.of(context).size.width,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildHeader(), Cardinfo(), _buildcardinfo1()],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedOpacity(
      duration: const Duration(seconds: 2),
      opacity: _showLoginCard1 ? 1.0 : 0.0,
      child: AnimatedPadding(
        duration: const Duration(seconds: 2),
        padding: EdgeInsets.only(top: _showLoginCard1 ? 0 : 100),
        child: SizedBox(
          height: 70,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
            shadowColor: Colors.grey.withOpacity(0.2),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'DEPARTMENT DASHBOARD',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text(
                          'Refresh',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildcardinfo1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(spacing: 30, children: [Circulaindicator()]),
          ),
        ),
      ],
    );
  }
}
