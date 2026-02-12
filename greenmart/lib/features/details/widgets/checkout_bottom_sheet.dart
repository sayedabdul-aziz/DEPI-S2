import 'package:flutter/material.dart';
import 'package:greenmart/core/styles/colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/main_button.dart';

void showCheckoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // enableDrag: false,
    // isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.backgroundColor,

    builder: (context) {
      return CheckoutBottomSheet();
    },
  );
}

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * .9,
        minHeight: MediaQuery.sizeOf(context).height * .3,
      ),
      child: PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Checkout', style: TextStyles.subtitle),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.accentColor,
                  child: Icon(Icons.check, color: AppColors.backgroundColor),
                ),
                title: Text('Product 1', style: TextStyles.body),
                subtitle: Text('Quantity: 2', style: TextStyles.body),
                trailing: Text('\$50', style: TextStyles.body),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.accentColor,
                  child: Icon(Icons.check, color: AppColors.backgroundColor),
                ),
                title: Text('Product 1', style: TextStyles.body),
                subtitle: Text('Quantity: 2', style: TextStyles.body),
                trailing: Text('\$50', style: TextStyles.body),
              ),
              const Divider(),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.accentColor,
                  child: Icon(Icons.check, color: AppColors.backgroundColor),
                ),
                title: Text('Product 1', style: TextStyles.body),
                subtitle: Text('Quantity: 2', style: TextStyles.body),
                trailing: Text('\$50', style: TextStyles.body),
              ),

              MainButton(text: 'Checkout', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
