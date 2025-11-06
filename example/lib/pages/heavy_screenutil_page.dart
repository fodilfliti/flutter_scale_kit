import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as su;

/// Heavy page using flutter_screenutil for performance comparison
class HeavyScreenUtilPage extends StatelessWidget {
  const HeavyScreenUtilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return su.ScreenUtilInit(
      designSize: const Size(375, 812),
      builder:
          (_, __) => Scaffold(
            appBar: AppBar(title: const Text('flutter_screenutil Heavy Page')),
            body: ListView.builder(
              padding: EdgeInsets.all(su.ScreenUtil().setWidth(12)),
              itemCount: 600,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: su.ScreenUtil().setHeight(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(su.ScreenUtil().setWidth(12)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        su.ScreenUtil().radius(10),
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: su.ScreenUtil().setWidth(1),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: su.ScreenUtil().setWidth(56),
                          height: su.ScreenUtil().setWidth(56),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(
                              su.ScreenUtil().radius(8),
                            ),
                          ),
                        ),
                        SizedBox(width: su.ScreenUtil().setWidth(12)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Item #$index - Title',
                                style: TextStyle(
                                  fontSize: su.ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: su.ScreenUtil().setHeight(6)),
                              Text(
                                'Subtitle lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                'Phasellus efficitur, neque a interdum congue, justo arcu.',
                                style: TextStyle(
                                  fontSize: su.ScreenUtil().setSp(12),
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(height: su.ScreenUtil().setHeight(8)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: su.ScreenUtil().setSp(14),
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: su.ScreenUtil().setWidth(6)),
                                  Text(
                                    '4.${index % 10}',
                                    style: TextStyle(
                                      fontSize: su.ScreenUtil().setSp(12),
                                    ),
                                  ),
                                  SizedBox(width: su.ScreenUtil().setWidth(12)),
                                  Icon(
                                    Icons.timer,
                                    size: su.ScreenUtil().setSp(14),
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: su.ScreenUtil().setWidth(6)),
                                  Text(
                                    '${(index % 50) + 1}m',
                                    style: TextStyle(
                                      fontSize: su.ScreenUtil().setSp(12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}
