import 'package:flutter/material.dart';


class ConfirmDeleteWidget{

 static void showAlertDeleteBox({required BuildContext context, required VoidCallback deleteButton, String? titleText, String? subText}){
    showDialog(
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: 260,
                    height: 300,
                    child: AlertDialog(
                      title: Text((titleText == null)?'Confirm to delete' : titleText,
                          style: Theme.of(context).textTheme.bodyLarge),
                      content: Text((subText == null)?'Are you sure you want to delete?': subText,
                          style: Theme.of(context).textTheme.labelLarge),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
                        ElevatedButton(
                          onPressed: () {
                            deleteButton.call();

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text('Yes',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}