class EventModel {
  EventModel({
    required this.eventId,
    required this.eventName,
    required this.location,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.eventDates,
  });
  late final int eventId;
  late final String eventName;
  late final String location;
  late final String image;
  late final String startDate;
  late final String endDate;
  late final List<EventDates> eventDates;
  
  EventModel.fromJson(Map<String, dynamic> json){
    eventId = json['eventId'];
    eventName = json['eventName'];
    location = json['location'];
    image = json['image'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    eventDates = List.from(json['eventDates']).map((e)=>EventDates.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['eventId'] = eventId;
    _data['eventName'] = eventName;
    _data['location'] = location;
    _data['image'] = image;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['eventDates'] = eventDates.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class EventDates {
  EventDates({
    required this.eventStart,
    required this.eventEnd,
  });
  late final String eventStart;
  late final String eventEnd;
  
  EventDates.fromJson(Map<String, dynamic> json){
    eventStart = json['eventStart'];
    eventEnd = json['eventEnd'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['eventStart'] = eventStart;
    _data['eventEnd'] = eventEnd;
    return _data;
  }
}