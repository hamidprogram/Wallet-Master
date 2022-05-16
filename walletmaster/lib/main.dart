import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hive/hive.dart';
import 'package:walletmaster/BE/Cards.dart';
import 'package:walletmaster/about.dart';
import 'package:walletmaster/cards_screen.dart';
import 'BE/Buys.dart';
import 'buys_screen.dart';
import 'context.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BuyAdapter());
  Hive.registerAdapter(CardAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          Icon(Icons.water_damage, size: 30, color: Colors.black),
          Icon(Icons.account_circle, size: 30, color: Colors.black),
        ],
        index: 0,
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
            const Center(
              child: Text(
                'Wallet',
                style: TextStyle(color: kTextColor, fontSize: 23),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            kPinkColor,
                            kBlueColor,
                          ],
                        ),
                      ),
                      width: (MediaQuery.of(context).size.width - 90),
                      height: 160,
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                      child: FutureBuilder(
                        future: Hive.openBox('cards'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState == ConnectionState.done) {
                            return showCard();
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(color: kTextColor, fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => buyscreen(
                                    type: 'add',
                                    index: -1,
                                    text: '',
                                    mony: '',
                                    date: '',
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ))
                ],
              ),
            ),
            FutureBuilder(
              future: Hive.openBox('buys'),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return buysList();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void swichscren(int page) {
    if (page == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const bankcard()),
      );
    }
  }
  //Hamid@1383022715
  Widget buysList() {
    Box buysBox = Hive.box('buys');
    return ValueListenableBuilder(
        valueListenable: buysBox.listenable(),
        builder: (context, Box box, child) {
          if (box.values.isEmpty) {
            return const Center(
                child: Text(
              'No Buys',
              style: TextStyle(color: Colors.white),
            ));
          } else {
            return SizedBox(
              height: (MediaQuery.of(context).size.height - 395),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: buysBox.length,
                itemBuilder: (context, index) {
                  final Buy buy = box.getAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => buyscreen(
                                  type: 'edit',
                                  index: index,
                                  text: buy.buytitle,
                                  mony: buy.mony,
                                  date: buy.date,
                                )),
                      );
                    },
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 0,
                        ),
                      ),
                      color: kListItemColor,
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: kListItemIconColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 45,
                          width: 50,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_shopping_cart_sharp,
                              color: kListItemIconnColor,
                            ),
                            onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(buy.date)
                              ));
                            }
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              buy.buytitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(buy.mony),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline_outlined,
                              color: Colors.red),
                          onPressed: () {
                            Delete(index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        });
  }

  void Delete(int index) {
    var box = Hive.box('buys');
    box.deleteAt(index);
  }

  Widget showCard() {
    Box cardsBox = Hive.box('cards');
    return ValueListenableBuilder(
        valueListenable: cardsBox.listenable(),
        builder: (context, Box box, child) {
          if (box.values.isEmpty) {
            return Row(
              children: [
                const Center(
                    child: Text(
                  'Tab butoon to add card',
                  style: TextStyle(color: Colors.white),
                )),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => cardscreen(
                            type: 'add',
                            index: -1,
                            numbercard: '',
                            cvvcard: '',
                            datecard: '',
                            namecard: '',
                          )),
                    );
                  },
                ),
              ],
            );
          } else {
            final Cardd cardd = box.getAt(0);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => cardscreen(
                        type: 'edit',
                        index: 0,
                        numbercard: cardd.numbercard,
                        cvvcard: cardd.cvvcard,
                        datecard: cardd.datecard,
                        namecard: cardd.namecard,
                      )),
                );
              },
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        cardd.numbercard,
                        style: const TextStyle(color: kTextColor, fontSize: 27),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('CVV2'+cardd.cvvcard), Text(cardd.datecard)],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          cardd.namecard,
                          style: const TextStyle(color: kTextColor),
                        )
                      ],
                    ),
                  ],
                ),
                width: (MediaQuery.of(context).size.width - 50),
                height: 160,
              ),
            );
          }
        });
  }
}
