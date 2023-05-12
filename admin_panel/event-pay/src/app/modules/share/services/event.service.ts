import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Event } from '../../dashboard/classes/event.class';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class EventService {

  constructor(
    protected http: HttpClient
  ) { }

  public getAllEvents(user: any): any {
    const httpProperties = {
      headers: new HttpHeaders({
        'WorkerUsername': 'janez'
      })
    };

    return this.http.get<any>(environment.url+'/events', httpProperties);
  }

  public postEvent(e: Event): any {
    return this.http.post<any>(environment.url+'/events', {
      'eventName': e.eventName,
      'description': e.description,
      'location': e.location,
      'dates': e.eventDates,
      'trr': e.trr,
      'image': e.image,
      'cardImage': e.cardImage,
      'workerUsername': e.workerUsername
    });
  }
}
