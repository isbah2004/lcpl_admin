import 'package:flutter/material.dart';
import 'package:lcpl_admin/reusablewidgets/neomorphism_widget.dart';
import 'package:lcpl_admin/theme/theme.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const ReusableButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: GestureDetector(
        onTap: onTap,
        child: NeomorphicWidget(
          child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.blueColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: loading
                  ? const CircularProgressIndicator(color: AppTheme.whiteColor)
                  : Text(textAlign: TextAlign.center,
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
        ),
      ),
    );
  }
}
