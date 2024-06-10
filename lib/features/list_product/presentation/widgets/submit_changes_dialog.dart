import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:base_1/core/config/app_colors.dart';
import 'package:base_1/features/list_product/presentation/bloc/list_product_bloc.dart';
import 'package:base_1/features/list_product/presentation/widgets/product_item.dart';

class SubmitChangesDialog extends StatelessWidget {
  const SubmitChangesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      title: const Center(
        child: Text("Submit changes"),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<ListProductBloc, ListProductState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.listProduct.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                final product = state.listProduct[index];
                return ProductItem(
                  isEdit: false,
                  product: product,
                );
              },
            );
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                ),
                onPressed: () async {
                  /// TODO integrate with API to submit changes
                  SmartDialog.showLoading(msg: 'Submitting changes...');
                  await Future.delayed(const Duration(seconds: 2)).then(
                    (value) => Navigator.pop(context),
                  );
                  SmartDialog.showToast(
                    'Changes submitted successfully',
                    alignment: Alignment.center,
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
