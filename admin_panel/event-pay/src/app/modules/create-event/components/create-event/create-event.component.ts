import { Component, OnInit } from '@angular/core';
import { Event } from 'src/app/modules/dashboard/classes/event.class';
import { EventService } from 'src/app/modules/share/services/event.service';

@Component({
  selector: 'app-create-event',
  templateUrl: './create-event.component.html',
  styleUrls: ['./create-event.component.scss']
})
export class CreateEventComponent implements OnInit {

  eventName: string = '';
  location: string = '';
  startDate: Date = new Date(123);
  endDate: Date = new Date(123);
  dateDescription: string = '';
  description: string = '';
  image: string = '';
  cardImage: string = '';
  trr: string = '';

  constructor(
    private eventService: EventService
  ) { }

  ngOnInit(): void {
  }

  onPostClick() {
    let newEvent = new Event({
      eventName: this.eventName,
      location: this.location,
      startDate: new Date(this.startDate),
      endDate: new Date(this.endDate),
      eventDates: [
        {
          'eventStart': new Date(this.startDate),
          'eventEnd': new Date(this.endDate),
          'description': this.description
        }
      ],
      trr: this.trr,
      image: this.image,
      cardImage: this.cardImage,
      workerUsername: localStorage.getItem('username')?.toString()
    });

    let res = this.eventService.postEvent(newEvent);
  }

}
