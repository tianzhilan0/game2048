/*
 * @Descripttion: 
 * @version: 
 * @Author: lichuang
 * @Date: 2021-01-21 14:42:18
 * @LastEditors: lichuang
 * @LastEditTime: 2021-01-21 17:25:32
 */
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<int>> _datas;
  int newData = 2;

  @override
  void initState() {
    super.initState();
    _datas = initData();
    _datas = addNumber(_datas);
    _datas = addNumber(_datas);
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              height: _width,
              // color: Colors.orangeAccent,
              child: GridView.builder(
                  itemCount: 16,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: 4,
                      //纵轴间距
                      mainAxisSpacing: 10.0,
                      //横轴间距
                      crossAxisSpacing: 10.0,
                      //子组件宽高长度比例
                      childAspectRatio: 1.0),
                  itemBuilder: (context, index) {
                    var x = index % 4;
                    int y = (index ~/ 4).toInt();

                    var value = _datas[y][x];
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        value == 0 ? "" : value.toString(),
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      color: value > 0 ? Colors.orange[700] : Colors.orange,
                    );
                  }),
            ),
            onVerticalDragEnd: (details) {
              print(details.primaryVelocity);
              if (details.primaryVelocity > 0) {
                // 往下
                handleGesture(GridGesture.down);
              } else {
                // 往上
                handleGesture(GridGesture.up);
              }
            },
            onHorizontalDragEnd: (details) {
              print(details.primaryVelocity);

              if (details.primaryVelocity > 0) {
                // 往右
                handleGesture(GridGesture.right);
              } else {
                // 往左
                handleGesture(GridGesture.left);
              }
            },
          )
        ],
      ),
    );
  }

  handleGesture(int gesture) {
    List<List<int>> newData = initData();

    if (gesture == GridGesture.up || gesture == GridGesture.down) {
      for (var i = 0; i < 4; i++) {
        // 获取竖方向数组
        List<int> hasNumberList = List<int>();
        hasNumberList.add(_datas[0][i]);
        hasNumberList.add(_datas[1][i]);
        hasNumberList.add(_datas[2][i]);
        hasNumberList.add(_datas[3][i]);
        print("hasNumberList == $hasNumberList");
        // 去除0
        hasNumberList.removeWhere((element) => element == 0);
        print("hasNumberList == $hasNumberList");
        // 合并相同数的数字
        hasNumberList = combine(hasNumberList);
        // 去除0
        hasNumberList.removeWhere((element) => element == 0);
        // 补全0
        List<int> noNumberList = getZeroList(4 - hasNumberList.length);
        print("noNumberList == $noNumberList");

        List combineArray = gesture == GridGesture.up
            ? hasNumberList + noNumberList
            : noNumberList + hasNumberList;
        newData[0][i] = combineArray[0];
        newData[1][i] = combineArray[1];
        newData[2][i] = combineArray[2];
        newData[3][i] = combineArray[3];
        print("合并后 == $newData");
      }
    } else if (gesture == GridGesture.left || gesture == GridGesture.right) {
      for (var i = 0; i < 4; i++) {
        // 获取横方向数组
        List<int> hasNumberList = List<int>();
        hasNumberList.addAll(_datas[i]);
        // 去除0
        hasNumberList.removeWhere((element) => element == 0);
        print("hasNumberList == $hasNumberList");
        // 合并相同数的数字
        hasNumberList = combine(hasNumberList);
        // 去除0
        hasNumberList.removeWhere((element) => element == 0);
        // 补全0
        List<int> noNumberList = getZeroList(4 - hasNumberList.length);
        print("noNumberList == $noNumberList");

        newData[i] = gesture == GridGesture.left
            ? hasNumberList + noNumberList
            : noNumberList + hasNumberList;
        print("合并后 == $newData");
      }
    }

    setState(() {
      _datas = newData;
    });

    _datas = addNumber(_datas);
    setState(() {});
  }

  // 合并相同数字
  List<int> combine(List<int> array) {
    for (var i = 0; i < array.length - 1; i++) {
      int a = array[i];
      int b = array[i + 1];
      if (a == b) {
        array[i] = a + b;
        array[i + 1] = 0;
      }
    }
    return array;
  }

  // 数组补零
  List<int> getZeroList(int number) {
    List<int> array = List<int>();
    for (var i = 0; i < number; i++) {
      array.add(0);
    }
    return array;
  }

  /// 移动数据
  List<List<int>> mobileNumber(List<List<int>> data, int gesture) {
    return data;
  }

  /// 添加数据
  List<List<int>> addNumber(List<List<int>> data) {
    List<GridPoint> points = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (data[i][j] == 0) {
          points.add(GridPoint(i, j));
        }
      }
    }
    if (points.length > 0) {
      int index = Random().nextInt(points.length);
      GridPoint point = points[index];
      int r = Random().nextInt(100);
      data[point.x][point.y] = r > 50 ? 4 : 2;
    }

    return data;
  }

  List<List<int>> initData() {
    return [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ];
  }
}

class GridPoint {
  int x;
  int y;

  GridPoint(this.x, this.y);
}

class GridGesture {
  static const int up = 0;
  static const int down = 1;
  static const int left = 2;
  static const int right = 3;
}
