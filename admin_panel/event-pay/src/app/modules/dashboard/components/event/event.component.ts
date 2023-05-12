import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Event } from '../../classes/event.class';

@Component({
  selector: 'app-event',
  templateUrl: './event.component.html',
  styleUrls: ['./event.component.scss']
})
export class EventComponent implements OnInit {

  public event: Event = new Event({});
  public subEvents: any[] = [];

  constructor(
    protected activatedRoute: ActivatedRoute
  ) { }

  ngOnInit(): void {

    this.activatedRoute.params.subscribe(params => {
      this.event.endDate = params['endDate'];
      this.event.eventId = params['eventId'];
      this.subEvents = params['eventDates'];
      this.event.eventName = params['eventName'];
      this.event.image = params['image'];
      this.event.location = params['location']; 
      this.event.startDate = params['startDate'];
    });

  }

}
