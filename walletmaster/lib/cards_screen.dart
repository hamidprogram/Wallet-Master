import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walletmaster/context.dart';
import 'package:hive/hive.dart';
import 'BE/Buys.dart';
import 'BE/Cards.dart';

class cardscreen extends StatelessWidget {
  cardscreen({Key? key, required this.type, required this.index, required this.numbercard, required this.cvvcard, required this.datecard, required this.namecard}) : super(key: key);

  final String type;
  final int index;
  final String numbercard;
  final String cvvcard;
  final String datecard;
  final String namecard;
  TextEditingController numbercardcontroller = TextEditingController();
  TextEditingController cvvcardcontroller = TextEditingController();
  TextEditingController datecardcontroller = TextEditingController();
  TextEditingController namecardcontroller = TextEditingController();
  late BuildContext con;

  @override
  Widget build(BuildContext context) {
    con = context;
    if(type == 'edit'){
      numbercardcontroller.text = numbercard;
      cvvcardcontroller.text = cvvcard;
      datecardcontroller.text = datecard;
      namecardcontroller.text = namecard;
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kBackGroundColor,
          elevation: 0,
          title: Text(
            type == 'add'?'Add Card':'Edit Card',
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
              controller: numbercardcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  labelText: 'Add number Card:0000-0000-0000-0000'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: cvvcardcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  labelText: 'Add CVV2 Card'),
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: datecardcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  labelText: 'Add date Card'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: namecardcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  labelText: 'Add name Card'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                onPress(numbercardcontroller.text,cvvcardcontroller.text,datecardcontroller.text,namecardcontroller.text);
              },
              child: Text(type == 'add'?'Add Card':'Edit Card',style: const TextStyle(color: Colors.white),),
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
  void onPress(String number,cvv,date,name){
    if(type == 'add'){
      add(number,cvv,date,name);
    }
    else{
      edit(number,cvv,date,name);
    }
  }
  add(String number,cvv,date,name)async{
    var box = await Hive.box('cards');
    Cardd cardd = Cardd(number,cvv,date,name);
    box.add(cardd);
    numbercardcontroller.clear();
    cvvcardcontroller.clear();
    datecardcontroller.clear();
    namecardcontroller.clear();
    Navigator.pop(con);
  }
  edit(String number,cvv,date,name)async{
    var box = await Hive.box('cards');
    Cardd cardd = Cardd(number,cvv,date,name);
    box.putAt(index,cardd);
  }
}
