import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_1/core/config/app_colors.dart';
import 'package:base_1/core/config/app_constatns.dart';
import 'package:base_1/core/util/validator_utils.dart';
import 'package:base_1/features/list_product/domain/entites/product.dart';
import 'package:base_1/features/list_product/domain/entites/product_color.dart';
import 'package:base_1/features/list_product/presentation/bloc/list_product_bloc.dart';
import 'package:base_1/features/list_product/presentation/widgets/image_placeholder.dart';

class EditProductBottomSheet extends StatefulWidget {
  final Product? product;
  const EditProductBottomSheet({Key? key, this.product}) : super(key: key);

  @override
  State<EditProductBottomSheet> createState() => _EditProductBottomSheetState();
}

class _EditProductBottomSheetState extends State<EditProductBottomSheet>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController =
      TextEditingController(text: '');
  final TextEditingController _skuController = TextEditingController(text: '');
  final imageSize = const Size(80, 80);
  ProductColor? _selectedColor;

  @override
  void initState() {
    _productNameController.text = widget.product?.name ?? '';
    _skuController.text = widget.product?.sku ?? '';
    _selectedColor = widget.product?.productColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.product?.image ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          height: imageSize.height,
                          width: imageSize.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => ImagePlaceHolder(
                          size: imageSize,
                        ),
                        errorWidget: (context, url, error) => ImagePlaceHolder(
                          size: imageSize,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          'Error: ${widget.product?.errorDescription ?? ''}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _productNameController,
                    maxLength: Constants.productNameMaxLength,
                    validator: ValidatorUtils.productNameValidator,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter product name ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _skuController,
                    maxLength: Constants.skuMaxLength,
                    validator: ValidatorUtils.skuValidator,
                    decoration: InputDecoration(
                      labelText: 'SKU',
                      hintText: 'Enter sku ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  BlocConsumer<ListProductBloc, ListProductState>(
                    listener: (context, state) => listener(state),
                    bloc: context.read<ListProductBloc>(),
                    builder: (context, state) {
                      return DropdownButtonFormField<ProductColor?>(
                        value: state.listProductColor.firstWhereOrNull(
                          (element) => element.id == widget.product?.color,
                        ),
                        onChanged: (ProductColor? value) {
                          _selectedColor = value;
                        },
                        items: state.listProductColor
                            .map(
                              (ProductColor? productColor) =>
                                  DropdownMenuItem<ProductColor?>(
                                value: productColor,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: productColor?.hexColor,
                                        border: Border.all(
                                          color:
                                              AppColors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      productColor?.name ?? '',
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        decoration: InputDecoration(
                          hintText: 'Select color ...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
                    onPressed: () {
                      _editProduct(_selectedColor);
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void listener(ListProductState state) {
    if (state.status == GetProductStatus.editSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Edit product success'),
          showCloseIcon: true,
        ),
      );
      Navigator.pop(context);
    }
  }

  void _editProduct(ProductColor? productColor) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String productName = _productNameController.text;
      String sku = _skuController.text;

      context.read<ListProductBloc>().add(
            EditProductEvent(
              product: Product(
                id: widget.product?.id,
                name: productName,
                sku: sku,
                image: widget.product?.image,
                color: productColor?.id ?? widget.product?.color,
                productColor: productColor,
                hexColor: productColor?.hexColor,
                errorDescription: widget.product?.errorDescription,
              ),
            ),
          );
    }
  }
}
