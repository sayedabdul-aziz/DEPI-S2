import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SelectGovernorateBottomSheet extends StatelessWidget {
  const SelectGovernorateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        var cubit = context.read<CheckoutCubit>();
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Governorate', style: TextStyles.title),
              const Gap(20),
              if (state is GetGovernoratesLoading)
                const Center(child: CircularProgressIndicator())
              else if (state is GetGovernoratesError)
                const Center(child: Text('Error loading governorates'))
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: cubit.governorates.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      var governorate = cubit.governorates[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          governorate.governorateNameEn ?? '',
                          style: TextStyles.body,
                        ),
                        onTap: () {
                          cubit.selectGovernorate(governorate);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
