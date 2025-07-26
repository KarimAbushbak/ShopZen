import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';

class DotIndicator extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final double size;

  const DotIndicator({
    super.key,
    required this.color,
    required this.isSelected,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: isSelected
            ? Border.all(color: Colors.blueAccent, width: 3)
            : null,
        
      ),
    );
  }
}
class DotIndicatorRow extends StatelessWidget {
  const DotIndicatorRow({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.purple,
      Colors.black,
      Colors.blue,
      Colors.pink,
    ];

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is ProductLoaded && state.selectedColorIndex != null) {
          selectedIndex = state.selectedColorIndex!;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(colors.length, (index) {
            return GestureDetector(
              onTap: () {
                context.read<ProductCubit>().selectColor(index);
              },
              child: DotIndicator(
                color: colors[index],
                isSelected: selectedIndex == index,
              ),
            );
          }),
        );
      },
    );
  }
}

