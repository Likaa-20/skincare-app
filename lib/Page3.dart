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
  double _sum = 0; // holds total price for selected products
  bool _showSelected = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // displays the total price
        title: Text('Total Price: \$$_sum'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          // displays reset icon in AppBar
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
          // displays show selected icon in AppBar
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
      // check if we need to display selected items or menu
      // it depends on the _showSelected field
      body: _showSelected ? ShowSelectedProducts(width: screenWidth, selectedSkin: widget.selectedSkin) :
      ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          // Check if product matches selected skin type
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
                          // add its price to total price
                          _sum += products[index].price;
                        } else {
                          // subtract its price from total price
                          _sum -= products[index].price;
                        }
                        setState(() {});
                      }),
                  Text(products[index].toString()),
                ]),
                // get image from assets
                Image.asset(
                  products[index].image,
                  height: screenWidth * 0.3,
                  errorBuilder: (context, error, stackTrace) {
                    // If image not found, show placeholder
                    return Container(
                      height: screenWidth * 0.3,
                      width: screenWidth * 0.8,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[600],
                        size: 50,
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            // If product doesn't match skin type, return empty container
            return Container();
          }
        },
      ),
    );
  }
}

// Show Selected Products Widget (like ShowSelectedItems in your lecture)
class ShowSelectedProducts extends StatelessWidget {
  const ShowSelectedProducts({required this.width, required this.selectedSkin, Key? key}) : super(key: key);
  final double width;
  final Skin selectedSkin;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) {
        if (products[index].selected && products[index].skinType == selectedSkin.type) {
          return Column(children: [
            const SizedBox(height: 10),
            SizedBox(width: width * 0.28),
            Text(products[index].toString(), style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // get image from assets
            Image.asset(
              products[index].image,
              height: width * 0.3,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: width * 0.3,
                  width: width * 0.8,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[600],
                    size: 50,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
          ]);
        } else {
          return Container();
        }
      },
    );
  }
}

