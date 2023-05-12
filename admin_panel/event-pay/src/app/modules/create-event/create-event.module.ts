import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CreateEventRoutingModule } from './create-event-routing.module';
import { CreateEventComponent } from './components/create-event/create-event.component';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    CreateEventComponent
  ],
  imports: [
    CommonModule,
    CreateEventRoutingModule,
    FormsModule
  ]
})
export class CreateEventModule { }
