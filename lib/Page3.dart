import 'package:flutter/material.dart';
import 'User.dart';
import 'skinType.dart';
import 'Product.dart';
class Page3 extends StatefulWidget {
  final User user;
  final Skin selectedSkin;

  const Page3({Key? key, required this.user, required this.selectedSkin}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  double _sum = 0;
  bool _showSelected = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Total Price: \$$_sum'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          Tooltip(
              message: 'Reset selection',
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _sum = 0;
                    for (var e in products) {
                      e.selected = false;
                    }
                    _showSelected = false;
                  });
                },
                icon: const Icon(
                  Icons.restore,
                ),
              )),
          Tooltip(
              message: 'Show/Hide Selected Items',
              child: IconButton(
                onPressed: () {
                  if (_sum != 0) {
                    setState(() {
                      _showSelected = !_showSelected;
                    });
                  }
                },
                icon: const Icon(
                  Icons.shopping_cart_checkout,
                ),
              ))
        ],
      ),
      body: _showSelected ? ShowSelectedProducts(width: screenWidth, selectedSkin: widget.selectedSkin) :
      ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          if (products[index].skinType == widget.selectedSkin.type) {
            return Column(
              children: [
                Row(children: [
                  SizedBox(width: screenWidth * 0.24),
                  Checkbox(
                      value: products[index].selected,
                      onChanged: (e) {
                        products[index].selected = e as bool;
                        if (products[index].selected) {
                          _sum += products[index].price;
                        } else {
                          _sum -= products[index].price;
                        }
                        setState(() {});
                      }),
                  Text(products[index].toString()),
                ]),
                Image.asset(
                  products[index].image,
                  height: screenWidth * 0.3,
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ShowSelectedProducts extends StatelessWidget {
  const ShowSelectedProducts({required this.width, required this.selectedSkin, Key? key}) : super(key: key);
  final double width;
  final Skin selectedSkin;

  @override
  Widget build(BuildContext context) {
    List<Product> selectedProducts = [];
    for (var e in products) {
      if (e.selected && e.skinType == selectedSkin.type) {
        selectedProducts.add(e);
      }
    }
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: selectedProducts.length,
      itemBuilder: (context, index) {
        return Column(children: [
          const SizedBox(height: 10),
          SizedBox(width: width * 0.28),
          Text(selectedProducts[index].toString(), style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Image.asset(selectedProducts[index].image,
              height: width * 0.3),
          const SizedBox(height: 10),
        ]);
      },
    );
  }
}

