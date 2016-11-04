/* angular */
(function(){
  angular.module('app').controller('calendarCtrl', ['$scope', '$http', '$httpParamSerializerJQLike', function($scope, $http, $httpParamSerializerJQLike) {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $scope.events = [];

    $scope.setUp = function() {
      $http.get('/api/v1/events').then(function(response) {
        for(var i = 0; i < response.data.length; i++) {
          response.data[i].start = new Date(response.data[i].start)
          response.data[i].end = new Date(response.data[i].end)
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

    $scope.uiConfig = {
      calendar:{
        height: 650,
        editable: true,
        header:{
          left: 'title',
          center: '',
          right: 'today prev,next'
        },
        eventClick: $scope.alertOnEventClick
      }
    };

    $scope.eventSources = [$scope.events];
    window.$scope = $scope;
  }])

})();
