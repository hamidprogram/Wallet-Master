import 'package:flutter/material.dart';
import 'package:walletmaster/context.dart';
import 'package:hive/hive.dart';
import 'BE/Buys.dart';

class buyscreen extends StatelessWidget {
  buyscreen({Key? key, required this.type, required this.index, required this.text, required this.mony, required this.date}) : super(key: key);

  final String type;
  final int index;
  final String text;
  final String mony;
  final String date;
  TextEditingController controller = TextEditingController();
  TextEditingController controllerm = TextEditingController();
  TextEditingController controllerd = TextEditingController();
  late BuildContext con;

  @override
  Widget build(BuildContext context) {
    con = context;
    if(type == 'edit'){
      controller.text = text;
      controllerm.text = mony;
      controllerd.text = date;
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kBackGroundColor,
          elevation: 0,
          title: Text(
            type == 'add'?'Add Buys':'Edit Buys',
            style: const TextStyle(color: kTextColor),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: kTextColor,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  labelText: 'Add Buy content'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: controllerm,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  labelText: 'Add mony Buy'),
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: controllerd,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  labelText: 'Add date Buy'),
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                onPress(controller.text,controllerm.text,controllerd.text);
              },
              child: Text(type == 'add'?'Add Buy':'Edit Buy',style: const TextStyle(color: Colors.white),),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPinkColor),
                  fixedSize: MaterialStateProperty.all(
                      const Size(100,40)
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
  void onPress(String title,mony,date){
    if(type == 'add'){
      add(title,mony,date);
    }
    else{
      edit(title,mony,date);
    }
  }
  add(String title,mony,date)async{
    var box = await Hive.openBox('buys');
    Buy buy = Buy(title,mony,date);
    box.add(buy);
    controller.clear();
    controllerm.clear();
    controllerd.clear();
  }
  edit(String title,mony,date)async{
    var box = await Hive.openBox('buys');
    Buy buy = Buy(title,mony,date);
    box.putAt(index,buy);
    Navigator.pop(con);
  }
}
