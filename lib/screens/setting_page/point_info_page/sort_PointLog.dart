import 'package:shoppingapp/models/pointlog.dart';

List<dynamic> sortPointLog(List<PointLog> pointLogList){
  List<dynamic> result = [];
  List<PointLog> usePointLogList = [];
  List<PointLog> addPointLogList = [];


  for(int i = 0; i<pointLogList.length; i ++){
    PointLog pointLog = pointLogList[i];
    pointLog.usePoint ? usePointLogList.add(pointLog) : addPointLogList.add(pointLog);
  }

  result.add(pointLogList);
  result.add(usePointLogList);
  result.add(addPointLogList);

  return result;
}