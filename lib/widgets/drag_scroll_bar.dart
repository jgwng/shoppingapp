import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
class DraggableScrollbar extends StatefulWidget {
  final double heightScrollThumb;
  final Widget child;
  final double offset;
  final bool isRegister;
  final ScrollController controller;
//주
  DraggableScrollbar({this.heightScrollThumb, this.child, this.controller,this.offset,this.isRegister=false});

  @override
  _DraggableScrollbarState createState() => new _DraggableScrollbarState();
}

class _DraggableScrollbarState extends State<DraggableScrollbar> {
  //this counts offset for scroll thumb in Vertical axis
  double _barOffset;
  //this counts offset for list in Vertical axis
  double _viewOffset;
  //variable to track when scrollbar is dragged
  bool _isDragInProcess;
  bool isDragAtTop;
  bool isDragAtBottom;

  @override
  void initState() {
    super.initState();
    _barOffset = 0.0;
    _viewOffset = 0.0;
    _isDragInProcess = false;
    isDragAtTop = false;
    isDragAtBottom = false;
  }

  //if list takes 300.0 pixels of height on screen and scrollthumb height is 40.0
  //then max bar offset is 260.0ㅁ
  double get barMaxScrollExtent =>
      context.size.height - widget.heightScrollThumb;
  double get barMinScrollExtent => 0.0;

  //this is usually length (in pixels) of list
  //if list has 1000 items of 100.0 pixels each, maxScrollExtent is 100,000.0 pixels
  double get viewMaxScrollExtent => widget.controller.position.maxScrollExtent;
  //this is usually 0.0
  double get viewMinScrollExtent => widget.controller.position.minScrollExtent;

  double getScrollViewDelta(
      double barDelta,
      double barMaxScrollExtent,
      double viewMaxScrollExtent,
      ) {//propotion
    return barDelta * viewMaxScrollExtent / barMaxScrollExtent;
  }

  double getBarDelta(
      double scrollViewDelta,
      double barMaxScrollExtent,
      double viewMaxScrollExtent,
      ) {//propotion
    return scrollViewDelta * barMaxScrollExtent / viewMaxScrollExtent;
  }

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      print("dragStart : ${details.globalPosition.dy}");
      _isDragInProcess = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      print("dragEnd : ${details.velocity.toString()}");
      _isDragInProcess = false;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _barOffset += details.delta.dy;
      print("_barOffset : $_barOffset");
      if (_barOffset < barMinScrollExtent) {
        _barOffset = barMinScrollExtent;
        print("_barOffset : $_barOffset");
      }
      if (_barOffset > barMaxScrollExtent) {
        _barOffset = barMaxScrollExtent-60;
        print("_barOffset : $_barOffset");
      }

      double viewDelta = getScrollViewDelta(
          details.delta.dy, barMaxScrollExtent, viewMaxScrollExtent);

      _viewOffset = widget.controller.position.pixels + viewDelta;
      if (_viewOffset < widget.controller.position.minScrollExtent) {
        _viewOffset = widget.controller.position.minScrollExtent;
        print("_barOffset : $_barOffset");
      }
      if (_viewOffset > viewMaxScrollExtent) {
        _viewOffset = viewMaxScrollExtent;
        print("_barOffset : $_barOffset");
      }
      widget.controller.jumpTo(_viewOffset);
    });
  }
  changePosition(ScrollNotification notification) {
    //if notification was fired when user drags we don't need to update scrollThumb position
    if (_isDragInProcess) {

      return;
    }

    setState(() {
      if (notification is ScrollUpdateNotification) {
        if(notification.metrics.outOfRange){
        }else{
          _barOffset += getBarDelta(
            notification.scrollDelta,
            barMaxScrollExtent,
            viewMaxScrollExtent,
          );
          if (_barOffset < barMinScrollExtent) {
            _barOffset = barMinScrollExtent;
            print("_barOffset : $_barOffset");
          }
          if (_barOffset > barMaxScrollExtent) {
            _barOffset = barMaxScrollExtent;
            print("_barOffset : $_barOffset");
          }

          _viewOffset += notification.scrollDelta;
          if (_viewOffset < widget.controller.position.minScrollExtent) {
            _viewOffset = widget.controller.position.minScrollExtent;

          }
          if (_viewOffset > viewMaxScrollExtent) {
            _viewOffset = viewMaxScrollExtent;
          }
        }
      }
    }
    );
  }



  @override
  Widget build(BuildContext context) {

    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          changePosition(notification);

          return true;
        },
        child: Row(children: <Widget>[
          Flexible(child: widget.child),
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: (widget.isRegister) ? 20 : 10,
                    bottom: (widget.isRegister) ? 15 : 0,left: 20),
                width:5,
                height:size.height-widget.heightScrollThumb+(widget.isRegister ? -20 : 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(141, 110, 99, 0.3)
                ),
              ),
              GestureDetector(
                //we've add functions for onVerticalDragStart and onVerticalDragEnd
                //to track when dragging starts and finishes
                  onVerticalDragStart: _onVerticalDragStart,
                  onVerticalDragUpdate: _onVerticalDragUpdate,
                  onVerticalDragEnd: _onVerticalDragEnd,
                  child: Container(
                      margin: EdgeInsets.only(top: _barOffset+((widget.isRegister) ? widget.offset : 10)),
                      child: _buildScrollThumb())),
            ],
          ),
          SizedBox(width: (widget.isRegister) ? 20 : 5,child:
          Container(
            color: Colors.transparent,
          )),
        ]));
  }

  Widget _buildScrollThumb() {
    return  Container(
      height: widget.heightScrollThumb,
      margin: EdgeInsets.only(left: 20),
      width: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppThemes.mainColor,
      ),
    );
  }
}