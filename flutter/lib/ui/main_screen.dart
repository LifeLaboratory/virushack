import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palliative_chat/blocs/main/bloc.dart';
import 'package:palliative_chat/config/constants.dart';
import 'package:palliative_chat/ui/messages/rooms_list_screen.dart';

import 'calendar_screen.dart';
import 'common/texts.dart';
import 'directory_screen.dart';
import 'emergency_screen.dart';
import 'law_screen.dart';

class ScreenIndices {
  static const chat = 0;
  static const directory = 1;
  static const calendar = 2;
  static const emergency = 3;
  static const law = 4;
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedScreenIndex = ScreenIndices.chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return IndexedStack(
            children: [
              RoomsListScreen(),
              DirectoryScreen(),
              CalendarScreen(),
              EmergencyScreen(),
              LawScreen(),
            ],
            index: _selectedScreenIndex,
          );
        },
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      /*bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title:
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
          ),
        ],
      ),*/
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            _navigationBarItem(
              'Чат',
              Icons.chat_bubble_outline,
              AppImages.iconNavbarHomeOn,
              ScreenIndices.chat,
            ),
            _navigationBarItem(
              'Справка',
              Icons.info_outline,
              AppImages.iconNavbarMarketsOn,
              ScreenIndices.directory,
            ),
            _navigationBarItem(
              'План',
              Icons.date_range,
              AppImages.iconNavbarTradeOn,
              ScreenIndices.calendar,
            ),
            _navigationBarItem(
              'Срочно!',
              Icons.flash_on,
              AppImages.iconNavbarAssetsOn,
              ScreenIndices.emergency,
            ),
            _navigationBarItem(
              'Законы',
              Icons.assignment,
              AppImages.iconNavbarAccountOn,
              ScreenIndices.law,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigationBarItem(
    String title,
    IconData icon,
    String selectedIcon,
    int index,
  ) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => setState(() => _selectedScreenIndex = index),
          child: Container(
            height: 70.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  //padding: AppPadding.bottom(4.0),
                  padding: AppPadding.allZero,
                  child: Icon(
                    icon,
                    size: 20.0,
                    color: _selectedScreenIndex == index
                        ? Colors.redAccent
                        : Colors.black54,
                  ),
                ),
                Texts(
                  title,
                  color: _selectedScreenIndex == index
                      ? Colors.redAccent
                      : Colors.black54,
                  textSize: 12.0,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
