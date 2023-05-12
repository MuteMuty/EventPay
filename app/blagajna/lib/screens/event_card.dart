import 'package:blagajna/data/models/event_model.dart';
import 'package:blagajna/styles/colors.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  const EventCard(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/order", arguments: event.eventId),
        child: Card(
          child: Container(
            height: h * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    event.image),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Container(
              color: ThemeColors.backeground.withOpacity(0.45),
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, bottom: h *0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.eventName, style: TextStyle(color: Colors.white, fontSize: 24),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
