import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'context.dart';
import 'main.dart';

class bankcard extends StatelessWidget {
  const bankcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme:
      ThemeData.dark().copyWith(scaffoldBackgroundColor: kBackGroundColor),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: const [
          Icon(Icons.water_damage,size: 30,color: Colors.black),
          Icon(Icons.account_circle,size: 30,color: Colors.black),
        ],
        index: 1,
        height: 50,
        backgroundColor: kBackGroundColor,
        color: kListItemIconnColor,
        buttonBackgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _page = index;
            swichscren(_page);
          });
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      swichscren(0);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: kTextColor,
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 100),
                  child: Text(
                    'Wallet',
                    style: TextStyle(color: kTextColor, fontSize: 23),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.purple,
              ),
              height: (MediaQuery.of(context).size.height-400),
              width: (MediaQuery.of(context).size.width-25),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Hamid Master',style: TextStyle(fontSize: 30),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('hamidmaster.ir',style: TextStyle(fontSize: 30),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('09138742015',style: TextStyle(fontSize: 30),),
                  ),Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('hamidprogram@gmail.com',style: TextStyle(fontSize: 25),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void swichscren(int page){
    if (page == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }
  }
}
