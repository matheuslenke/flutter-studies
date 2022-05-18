import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';

class DetailItemListWidget extends StatelessWidget {
  const DetailItemListWidget({
    Key? key,
    required this.onChangePokemon,
    required this.list,
    required this.controller,
    required this.pokemon,
  }) : super(key: key);

  final ValueChanged<Pokemon> onChangePokemon;
  final List<Pokemon> list;
  final PageController controller;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (index) {
        onChangePokemon(list[index]);
      },
      controller: controller,
      children: list.map((e) {
        bool isDifferent = e.name != pokemon.name;
        return Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: isDifferent ? 0.4 : 1.0,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                  end: isDifferent ? 150 : 300, begin: isDifferent ? 300 : 150),
              builder: (context, value, child) {
                return Image.network(
                  e.image,
                  height: value,
                  fit: BoxFit.contain,
                  color: isDifferent ? Colors.black.withOpacity(0.4) : null,
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
