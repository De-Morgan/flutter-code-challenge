import 'package:flutter/material.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

typedef ItemWidgetBuilder<T> = Widget Function(int index, T item);

class Pagination<T> extends StatefulWidget {
  Pagination({
    Key key,
    @required this.pageBuilder,
    @required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.progress,
    this.onError,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.padding,
    this.itemExtent,
    this.cacheExtent,
    this.semanticChildCount,
  })  : assert(pageBuilder != null),
        assert(itemBuilder != null),
        super(key: key);

  /// Called when the list scrolls to an end
  ///
  /// Function should return Future List of type 'T'
  final PaginationBuilder<T> pageBuilder;

  /// Called to build children for [Pagination]
  ///
  /// Function should return a widget
  final ItemWidgetBuilder<T> itemBuilder;

  /// Scroll direction of list view
  final Axis scrollDirection;

  /// When non-null [progress] widget is called to show loading progress
  final Widget progress;

  /// Handle error returned by the Future implemented in [pageBuilder]
  final Function(dynamic error) onError;

  final bool reverse;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap = false;
  final EdgeInsetsGeometry padding;
  final double itemExtent;
  final bool addAutomaticKeepAlives = true;
  final bool addRepaintBoundaries = true;
  final bool addSemanticIndexes = true;
  final double cacheExtent;
  final int semanticChildCount;

  @override
  _PaginationState<T> createState() => _PaginationState<T>();
}

class _PaginationState<T> extends State<Pagination<T>> {
  final List<T> _list = List();
  bool _isLoading = false;
  bool _isEndOfList = false;

  void fetchMore() {
    if (!_isLoading) {
      _isLoading = true;
      widget.pageBuilder(_list.length).then((list) {
        _isLoading = false;
        if (list.isEmpty) {
          _isEndOfList = true;
        }
        setState(() {
          _list.addAll(list);
        });
      }).catchError((error) {
        setState(() {
          _isEndOfList = true;
        });
        print(error);
        if (widget.onError != null) {
          widget.onError(error);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMore();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      controller: widget.controller,
      physics: widget.physics,
      primary: widget.primary,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      itemExtent: widget.itemExtent,
      cacheExtent: widget.cacheExtent,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      scrollDirection: widget.scrollDirection,
      itemBuilder: (context, position) {
        if (position < _list.length) {
          return widget.itemBuilder(position, _list[position]);
        } else if (position == _list.length && !_isEndOfList) {
          fetchMore();
          return widget.progress ?? defaultLoading();
        }
        return null;
      },
    );
  }

  Widget defaultLoading() {
    return Align(
      child: SizedBox(
        height: 40,
        width: 40,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
