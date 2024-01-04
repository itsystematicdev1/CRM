import 'package:flutter/material.dart';
import '../../../widget/custom_floating_actions.dart';

CustomFloatingActionBotton buildFloatingActionButton({
  void Function()? onAdd,
  void Function()? onList,
  void Function()? onSearch,
}) {
    return CustomFloatingActionBotton(actionsList: [
      buildFloatingActionButtonItem(Icons.person_add_alt_1, 'Add New Contact',
         onAdd?? () {}),
      buildFloatingActionButtonItem(
        Icons.contact_page_rounded,
        'Import From Contacts',
        onList?? () {},
      ),
      buildFloatingActionButtonItem(
        Icons.search,
        'Search',
        onSearch?? () {},
      ),
    ]);
  }

  FloatingActionButton buildFloatingActionButtonItem(
    IconData icon,
    String tooltip,
    VoidCallback onPressed,
  ) {
    return FloatingActionButton.small(
      heroTag: null,
      tooltip: tooltip,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }