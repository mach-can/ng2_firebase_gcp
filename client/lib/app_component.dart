// Copyright (c) 2016, ntaoo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'home_component.dart';
import 'some_component.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    providers: const [
      ROUTER_PROVIDERS,
    ],
    directives: const [
      ROUTER_DIRECTIVES,
    ])
@RouteConfig(const [
  const Route(
      path: '/', name: 'Home', component: HomeComponent, useAsDefault: true),
  const Route(path: '/some', name: 'Some', component: SomeComponent)
])
class AppComponent {}
