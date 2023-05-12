import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthenticationService } from 'src/app/services/authentication.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  username: any = '';
  password: any = '';
  isWrongUsernameOrPassword: boolean = false;

  constructor(
    protected router: Router,
    private authService: AuthenticationService
    ) { }

  ngOnInit(): void {
    if (localStorage.getItem('user')) {
      this.redirect();
    }
  }

  login(): void {
    if (this.username === '' || this.password === '') return;
    this.authService.loginWithCredentials({'username':this.username, 'password':this.password})
    .toPromise()
    .then(res => this.loginUser(res))
    .catch(err => this.isWrongUsernameOrPassword = true);
  }

  private loginUser(res: any) {debugger;
    localStorage.setItem('username', res.username);
    localStorage.setItem('firstname', res.firstname);
    localStorage.setItem('lastname', res.lastname);
    localStorage.setItem('email', res.email);
    this.redirect();
  }

  private redirect(): void {
    this.router.navigateByUrl('home');
  }

}
