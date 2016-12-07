// Copyright (c) 2016, ntaoo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:client/check_authenticated.dart';
import 'package:client/model/service/auth_service.dart';

@Component(
    selector: 'some',
    template: 'Some auth required component. user is {{authService.user.displayName}}')
@CanActivate(checkAuthenticated)
class SomeComponent {
  AuthService authService;
  SomeComponent(this.authService);
}
