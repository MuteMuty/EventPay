import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BackboneComponent } from './modules/share/backbone/backbone.component';
import { LandingComponent } from './components/landing/landing.component';
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component';
import { DashboardComponent } from './modules/dashboard/components/dashboard/dashboard.component';

const routes: Routes = [
  {
    path: 'signin',
    component: LoginComponent
  },
  {
    path: 'signin/new-user',
    component: SignupComponent
  },
  {
    path: '',
    component: LandingComponent
  },
  {
    path: 'home',
    loadChildren: () => import('./modules/share/share.module').then(m => m.ShareModule),
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
