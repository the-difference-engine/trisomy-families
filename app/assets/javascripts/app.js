(function(){
  "use strict"

  var app = angular.module("app", ['ui.calendar', 'angular-directive-select-usstates']);

  app.config(['$httpProvider', function($httpProvider) {
   $httpProvider.defaults.headers.post = { 'Content-Type' : 'application/x-www-form-urlencoded' };
   $httpProvider.defaults.headers.put = { 'Content-Type' : 'application/x-www-form-urlencoded' };
   $httpProvider.defaults.paramSerializer = '$httpParamSerializerJQLike';
}]);

})();
