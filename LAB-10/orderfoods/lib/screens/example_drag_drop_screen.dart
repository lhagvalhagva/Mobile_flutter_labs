import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../models/item.dart';
import '../components/menu_list_item.dart';
import '../components/dragging_list_item.dart';
import 'order_screen.dart';
// ExampleDragAndDrop
// ├── MenuListItem (хоолны жагсаалт)
// ├── DraggingListItem (чирэх үеийн харагдац)
// └── OrderScreen (захиалгын дэлгэрэнгүй)

class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});

  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}

class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {
  final _draggableKey = GlobalKey();
  final Customer _customer = defaultCustomer;

  void _itemDroppedOnCustomerCart({
    required Item item,
    required Customer customer,
  }) {
    setState(() {
      customer.items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        'Order Food',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 36,
              color: const Color(0xFFF64209),
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildMenuList(),
              ),
              _buildPeopleRow(),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildMenuList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return _buildMenuItem(item: item);
      },
    );
  }

  Widget _buildMenuItem({required Item item}){
    return LongPressDraggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoProvider: item.imageProvider,
      ),
      child: MenuListItem(
        name: item.name,
        price: item.formattedTotalItemPrice,
        photoProvider: item.imageProvider,
      ),
    );
  }

  Widget _buildPeopleRow(){
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 20,
      ),
      width: double.infinity,
      child: DragTarget<Item>(
        builder: (context, candidateItems, rejectedItems) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: candidateItems.isNotEmpty 
                  ? Colors.blue.shade100 
                  : _customer.items.isNotEmpty 
                      ? Colors.blue.shade50 
                      : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: candidateItems.isNotEmpty 
                    ? Colors.blue.shade300
                    : _customer.items.isNotEmpty 
                        ? Colors.blue 
                        : Colors.grey.shade300,
              ),
            ),
            child: Stack(
              children: [
                _buildPersonWithDropZone(_customer),
                if (_customer.items.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        onWillAccept: (item) => true,
        onAccept: (item) {
          _itemDroppedOnCustomerCart(
            item: item,
            customer: _customer,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${item.name} сонгогдлоо'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPersonWithDropZone(Customer customer) {
    return ValueListenableBuilder<List<Item>>(
      valueListenable: customer.itemsNotifier,
      builder: (context, items, child) {
        return GestureDetector(
          onTap: () {
            if (customer.items.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(customer: customer),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Та эхлээд хоол сонгоно уу'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image(image: customer.imageProvider, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer.email,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  customer.formattedTotalItemPrice,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 