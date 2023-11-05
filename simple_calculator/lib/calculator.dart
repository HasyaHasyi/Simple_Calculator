import 'dart:math';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController la = new TextEditingController();
  TextEditingController lt = new TextEditingController();
  TextEditingController ir = new TextEditingController();
  double monthlyPayment = 0;
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator ',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Loan Calculator'),
        ),
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column ( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Payment Calculator", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                SizedBox(height: 100,),
                Form(child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Loan Amount"),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: la, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                          ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: Row(
                        children: [
                          Text("Loan Term"),
                          SizedBox(width: 25,),
                          Expanded(child: TextField(
                            controller: lt, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                          ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text("Interest Rate"),
                        SizedBox(width: 13,),
                        Expanded(child: TextField(
                          controller: ir,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))
                        ))
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       ElevatedButton(onPressed: _calculate , child: Text("Calculate")),
                       SizedBox(width: 13),
                       ElevatedButton(onPressed: _clear , child: Text("Clear"))
                      ],
                    )
                  ],
                )),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:15),
                      child: Row(
                        children: [
                          Container(
                            width: 342,
                            height: 50,
                            decoration: const BoxDecoration(color: Color.fromARGB(255, 120, 169, 255)),
                            child: Text('Monthly Payment : RM${monthlyPayment}', style: TextStyle(fontSize: 20),)),
                        ],
                      ),
                    ),
                    Text("You will need to pay RM${monthlyPayment} every month for ${lt.text} years to payoff the debt"),
                    SizedBox(height: 10,),
                    Text("Total of Payments ${monthlyPayment*12}"),
                    SizedBox(height: 10,),
                    Text("Total Interest ${ir.text}%"),
                  ],
                )  
              ],
            ),
          ),
        ),
      ),
    ); 
  }

   void _calculate() {
    double lainput = double.parse(la.text);
    int term = int.parse(lt.text);
    double interest = double.parse(ir.text) / 100 / 12;
    int totalpayment = term * 12;

    double num = interest * pow(1 + interest, totalpayment.toDouble());
    double dem = pow(1 + interest, totalpayment.toDouble()) - 1;
    double result = lainput * (num / dem);

    print('Result = ${result}');
    setState(() {
      monthlyPayment = double.parse(result.toStringAsFixed(2));
    });
  }

  void _clear() {
    la.clear();
    lt.clear();
    ir.clear();
  }
}