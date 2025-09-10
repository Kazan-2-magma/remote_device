import 'package:flutter/material.dart';
import 'package:remote_mouse/components/expandable_action_button.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;

    _animationController = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle(){
    print("Called");
    setState(() {
      _open = !_open;
      if(_open){
        _animationController.forward();
      }else {
        _animationController.reverse();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFap(),
        ],
      ),
    );
  }



  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.close, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTapToOpenFap(){
    print("Build");
    return IgnorePointer(
      ignoring: _open,

      child: AnimatedContainer(
          duration: const Duration(microseconds: 250),
          transformAlignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _open ? 0.8 : 1.0,
            _open ? 0.8 : 1.0,
            1.0,
          ),
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
          child: AnimatedOpacity(
            opacity: _open ? 0.0 : 1.0,
            curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
            duration: const Duration(milliseconds: 250),
            child: FloatingActionButton(
              backgroundColor: Colors.blue.shade200,
              onPressed: _toggle,
              foregroundColor: Colors.black87,
              child: const Icon(Icons.mouse),
            ),
          ),
        ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (
    var i = 0, angleInDegrees = 0.0;
    i < count;
    i++, angleInDegrees += step
    ) {
      children.add(
        ExpandableActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _animation,
          child: widget.children[i],
        ),
      );
    }
    print(children);
    return children;
  }
}