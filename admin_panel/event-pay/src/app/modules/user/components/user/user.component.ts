import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss']
})
export class UserComponent implements OnInit {

  firstName: string | null = localStorage.getItem('firstname');
  lastName: string | null = localStorage.getItem('lastname');
  email: string | null = localStorage.getItem('email');

  public editMode: boolean = false;

  constructor(
    protected router: Router
  ) { }

  ngOnInit(): void {
  }

  public toggleEditMode() {
    this.editMode = !this.editMode;
  }

  logout() {
    localStorage.removeItem('user');
    this.router.navigateByUrl('/');
  }

}
