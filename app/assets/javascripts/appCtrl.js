/* angular */
(function(){
  angular.module('app').controller('calendarCtrl', function($scope, $http, $httpParamSerializerJQLike) {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $scope.events = [];

    $scope.setUp = function() {
      $http.get('/api/v1/events').then(function(response) {
        for(var i = 0; i < response.data.length; i++) {
          $scope.events.push(response.data[i]);
        }
      })
    };

    $scope.event = {
      title: "",
      description: "",
      start: "",
      end: "",
      event_type: "",
      allDay: "",
      location: ""
    };

    $scope.createEvent = function() {
      $http({
          method: 'POST',
          url: '/api/v1/events',
          data: $httpParamSerializerJQLike($scope.event)
      });

      $scope.events.push($scope.event);

    };

    $scope.eventSources = [$scope.events];
    window.$scope = $scope;
  })

})();
