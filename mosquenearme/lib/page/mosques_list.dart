import 'package:flutter/material.dart';
import 'package:mosquenearme/model/mosque.dart';
import 'package:mosquenearme/provider/mosques_provider.dart';
import 'package:provider/provider.dart';

class MosquesList extends StatefulWidget {
  const MosquesList({super.key});

  @override
  State<MosquesList> createState() => _MosquesListState();
}

class _MosquesListState extends State<MosquesList> {
  @override
  Widget build(BuildContext context) {
    MosquesProvider mosquesProvider = Provider.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 200, // card height
          child: PageView.builder(
            itemCount: mosquesProvider.mosques.length,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) =>
                mosquesProvider.featuredMosque = index,
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == mosquesProvider.featuredMosque ? 1 : 0.8,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: MosqueCard(mosque: mosquesProvider.mosques[i]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MosqueCard extends StatelessWidget {
  final Mosque mosque;
  const MosqueCard({
    super.key,
    required this.mosque,
  });

  @override
  Widget build(BuildContext context) {
    NextPrayerInfos nextPrayerInfos = this.mosque.getNextPrayer();
    Color color = nextPrayerInfos.status == 1 ? Colors.green : Colors.red;
    return ListView(
      children: [
        Text(
          mosque.lib,
          style: TextStyle(fontSize: 26),
        ),
        Divider(),
        Text("الصلاة القادمة"),
        Text(nextPrayerInfos.lib),
        Text(
          nextPrayerInfos.time,
          style: TextStyle(color: color),
        ),
        Text(
          "${nextPrayerInfos.munitesLeft} دقائق",
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
