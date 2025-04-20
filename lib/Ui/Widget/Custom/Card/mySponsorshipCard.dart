part of '../../widget.dart';

class MySponsorshipCardX extends StatelessWidget {
  const MySponsorshipCardX({
    super.key,
    required this.sponsorship,
  });
  final SponsorshipX sponsorship;

  @override
  Widget build(BuildContext context) {
    return AccordionX(
      title: sponsorship.muslimNum!=null?"${"Muslim".tr} ${sponsorship.muslimNum!}":"Prayers for Islam",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActivityDataRowX(
            title: "Language",
            data: sponsorship.language,
          ).fadeAnimation100,
          ActivityDataRowX(
            title: "Gender",
            data: sponsorship.gender,
          ).fadeAnimation100,
          ActivityDataRowX(
            title: "Country",
            dataWidget: Row(
              children: [
                TextX(
                  sponsorship.country,
                  style: TextStyleX.titleSmall,
                ),
                const SizedBox(width: 8),
                if(sponsorship.countryFlagCode.toUpperCase()=='SY')
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset('assets/images/flags/sy.png',width: 25,height: 25,),
                ),
                if(sponsorship.countryFlagCode.toUpperCase()!='SY')
                CountryFlag.fromCountryCode(
                  sponsorship.countryFlagCode.toUpperCase(),
                  width: 25,
                  height: 25,
                  borderRadius: 6,
                )
              ],
            ),
          ).fadeAnimation200,
          if (sponsorship.previousReligion != null)
            ActivityDataRowX(
              title: "Previous religion",
              data: sponsorship.previousReligion!,
            ).fadeAnimation200,
          if (sponsorship.courseName != null)
            ActivityDataRowX(
              title: "Course name",
              data: sponsorship.courseName!.toString(),
            ).fadeAnimation300,
          ActivityDataRowX(
            title: "Donation amount",
            dataWidget: Row(children: [
              TextX(
                FunctionX.formatLargeNumber(sponsorship.donationAmount),
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              const SizedBox(width: 6),
              const Icon(IconX.sar,size: 15),
            ],),
          ).fadeAnimation300,
        ],
      ),
    );
  }
}
