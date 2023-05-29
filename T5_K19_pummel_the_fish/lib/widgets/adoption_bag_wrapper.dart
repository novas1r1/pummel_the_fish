import "package:flutter/material.dart";
import "package:pummel_the_fish/widgets/inherited_adoption_bag.dart";

// T5K19: Inherited Widget
class AdoptionBagWrapper extends StatefulWidget {
  final Widget child;

  const AdoptionBagWrapper({
    super.key,
    required this.child,
  });

  @override
  State<AdoptionBagWrapper> createState() => _AdoptionBagWrapperState();
}

class _AdoptionBagWrapperState extends State<AdoptionBagWrapper> {
  int _petCount = 0;

  @override
  Widget build(BuildContext context) {
    return InheritedAdoptionBag(
      petCount: _petCount,
      addPet: () {
        setState(() {
          _petCount++;
        });
      },
      child: widget.child,
    );
  }
}
