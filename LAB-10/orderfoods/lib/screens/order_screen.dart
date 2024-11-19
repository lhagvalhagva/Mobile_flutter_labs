import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../models/item.dart';

class OrderScreen extends StatefulWidget {
  final Customer customer;

  OrderScreen({Key? key, required this.customer}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Захиалга'),
            Text(
              widget.customer.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (widget.customer.items.isEmpty)
            const Expanded(
              child: Center(
                child: Text('Захиалга хоосон байна'),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: widget.customer.items.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = widget.customer.items[index];
                  return Dismissible(
                    key: Key(item.uid),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red.shade100,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red.shade700,
                      ),
                    ),
                    onDismissed: (direction) {
                      final removedItem = widget.customer.items[index];
                      
                      setState(() {
                        widget.customer.items.removeAt(index);
                        widget.customer.itemsNotifier.value = List.from(widget.customer.items);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${removedItem.name} устгагдлаа'),
                          action: SnackBarAction(
                            label: 'Буцаах',
                            onPressed: () {
                              setState(() {
                                widget.customer.items.insert(index, removedItem);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image(
                            image: item.imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(item.name),
                      trailing: Text(
                        item.formattedTotalItemPrice,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          if (widget.customer.items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              //Захиалгын нийт дүн (Bottom Container):
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Нийт дүн:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.customer.formattedTotalItemPrice,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    // Баталгаажуулах товч
                    child: ElevatedButton(
                      onPressed: () {
                        final itemNames = widget.customer.items
                            .map((item) => item.name)
                            .join(', ');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Захиалсан хоолнууд: $itemNames'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Захиалгыг баталгаажуулах'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

