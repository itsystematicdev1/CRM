import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import '../../../controllers/contacts/contacts_bindings.dart';
import 'customer_screen.dart';
import 'leads_screen.dart';
import 'loasted_customer.dart';

class ContactsScreen extends GetView<ContactBinding> {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildTabBarView(),
      floatingActionButtonLocation: ExpandableFab.location,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 8.0,
      bottom: buildTabBar(context),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  PreferredSize buildTabBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(5),
      child: TabBar(
        labelStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w600),
        labelColor: Theme.of(context).colorScheme.onPrimary,
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        unselectedLabelColor:
            Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        tabs: const <Widget>[
          Tab(text: 'مهتم'),
          Tab(text: 'عملاء'),
          Tab(text: 'فقد'),
        ],
      ),
    );
  }

  TabBarView buildTabBarView() {
    return  TabBarView(
      children: [
        const LeadsScreen(),
        CustomerScreen(),
        LostedCustomerScreen(),
       
      ],
    );
  }


}
