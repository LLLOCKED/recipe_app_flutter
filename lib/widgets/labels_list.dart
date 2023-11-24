import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelsList extends StatelessWidget {
  final List<String> labels;
  final Function(String) handleProductTap;

  const LabelsList(
      {super.key, required this.labels, required this.handleProductTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.6)),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(10).r,
          itemCount: labels.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                handleProductTap(labels[index]);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Container(
                    margin: EdgeInsets.only(bottom: 1.0.h),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20.r))),
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Text(
                        labels[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            );
          }),
    );
  }
}
