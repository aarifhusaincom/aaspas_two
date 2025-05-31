import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant_and_api/aaspas_constant.dart';

class WeekDayLetter extends StatelessWidget {
  const WeekDayLetter({
    super.key,
    required this.weekLetter,
    this.status = true,
  });
  final String weekLetter;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      width: 24,
      height: 24,
      child: Container(
        decoration: BoxDecoration(
          color:
              status ? AaspasColors.weekLetterBg : AaspasColors.deactivatedDiv,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        // width: 25,
        // height: 25,
        child: Text(
          weekLetter,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: status ? AaspasColors.black : AaspasColors.textDeactivated,
            ),
          ),
        ),
      ),
    );
  }
}
