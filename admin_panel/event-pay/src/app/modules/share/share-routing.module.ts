import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BackboneComponent } from './backbone/backbone.component';

const routes: Routes = [
    {
        path: '',
        component: BackboneComponent,
        children: [
            {
                path: '',
                loadChildren: () => import('../dashboard/dashboard.module').then(m => m.DashboardModule)
            },
            {
                path: 'create-event',
                loadChildren: () => import('../create-event/create-event.module').then(m => m.CreateEventModule)
            },
            {
                path: 'user',
                loadChildren: () => import('../user/user.module').then(m => m.UserModule)
            },
        ]
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ShareRoutingModule { }
