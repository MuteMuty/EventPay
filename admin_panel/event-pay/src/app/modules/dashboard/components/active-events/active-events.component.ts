import { Component, OnInit } from '@angular/core';
import { EventService } from 'src/app/modules/share/services/event.service';

@Component({
  selector: 'app-active-events',
  templateUrl: './active-events.component.html',
  styleUrls: ['./active-events.component.scss']
})
export class ActiveEventsComponent implements OnInit {

  activeEvents: any;

  constructor(
    private eventService: EventService
  ) { }

  ngOnInit(): void {
    this.getAllEvents();
  }

  getAllEvents() {
    this.activeEvents = this.eventService.getAllEvents('Matjaž');
  }
}
