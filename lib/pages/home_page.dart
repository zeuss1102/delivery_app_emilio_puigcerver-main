import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app_emilio_puigcerver/componets/my_current_location.dart';
import 'package:delivery_app_emilio_puigcerver/componets/my_description_box.dart';
import 'package:delivery_app_emilio_puigcerver/componets/my_food_tile.dart';
import 'package:delivery_app_emilio_puigcerver/componets/my_sliver_app_bar.dart';
import 'package:delivery_app_emilio_puigcerver/componets/my_tab_bar.dart';
import 'package:delivery_app_emilio_puigcerver/models/food.dart';
import 'package:delivery_app_emilio_puigcerver/models/restaurant.dart';
import 'package:delivery_app_emilio_puigcerver/pages/food_page.dart';
import 'package:delivery_app_emilio_puigcerver/pages/create_group_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // Controlador de pestañas
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Método para agregar un nuevo grupo
  void _createGroup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateGroupPage()),
    );
  }

  // Ordenar y devolver una lista de alimentos que pertenecen a una categoría específica
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // Devolver la lista de alimentos en la categoría dada
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      // Obtener categoria del menú
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          // Comida individual
          final food = categoryMenu[index];

          // Devolver ficha de comida UI
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodPage(food: food),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createGroup,
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                // Servira para la ubicación actual
                const MyCurrentLocation(),
                // Apartado de descripción de producto
                const MyDescriptionBox(),
              ],
            ),
          )
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(restaurant.menu),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createGroup,
        child: const Icon(Icons.add),
      ),
    );
  }
}

