import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';

class Transations extends StatefulWidget {
  const Transations({super.key});

  @override
  State<Transations> createState() => _TransationsState();
}

class _TransationsState extends State<Transations> {
  double totalB = 0;
  double sendB = 0;
  double reciveB = 0;

  @override
  Widget build(BuildContext context) {
    var container = Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 25,
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                budget(totalB, "Balance", Colors.black),
                const SizedBox(
                  width: 10,
                ),
                budget(sendB, "Will Send", Colors.green),
                budget(reciveB, "Will Recive", Colors.red)
              ]),
        ));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => bottomSheet(),
        ),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            container
          ],
        ),
      ),
    );
  }

  Widget budget(double cnt, String what, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "₹ $cnt",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: color),
        ),
        Text(
          what,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget bottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: const [
        SizedBox(
          height: 30,
        ),
        Text("HHH")
      ],
    );
  }
}
