/* global angular */
(function() {
  angular.module('app').controller('calendarCtrl', ['$scope', '$http', '$httpParamSerializerJQLike', function($scope, $http, $httpParamSerializerJQLike) {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $scope.events = [];

    $scope.setUp = function() {
      $http.get('/api/v1/events').then(function(response) {
        for(var i = 0; i < response.data.length; i++) {
          response.data[i].start = new Date(response.data[i].start);
          response.data[i].end = new Date(response.data[i].end);
          $scope.events.push(response.data[i]);
        }
      });
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

    $scope.alerts = [];

    $scope.createEvent = function() {
      $http({
        method: 'POST',
        url: '/api/v1/events',
        data: $httpParamSerializerJQLike($scope.event)

      }).then(function successCallback(response) {
        $scope.events.push($scope.event);
        $scope.alerts.push({ type: 'success', msg: 'Well done! You successfully added an event.' });
        document.getElementById('event_creator').style.display = 'none';
        document.getElementById('calendar').style.display = 'inline-block';

      }, function errorCallback(response) {
        $scope.alerts.push({ type: 'danger', msg: 'Oh snap! Change a few things up and try submitting again.' });
      });
    };

    $scope.closeAlert = function(index) {
      $scope.alerts.splice(index, 1);
    };

    $scope.uiConfig = {
      calendar:{
        height: 650,
        editable: true,
        customButtons: {
            myCustomButton: {
                text: '+',
                click: function() {
                    document.getElementById('event_creator').style.display = 'inline-block';
                    document.getElementById('calendar').style.display = 'none';
                    $("event_creator").focus();
                }
            }
        },
        views: {
          month: { // name of view
              titleFormat: 'MMMM YYYY'
              // other view-specific options here
          }
        },
        buttonText: {
          today: '↺'
        },
        header:{
          left: 'title',
          center: '',
          right: 'myCustomButton today prev,next'
        },
        eventClick: $scope.alertOnEventClick
      }
    };

    $scope.eventSources = [$scope.events];
    window.$scope = $scope;
  }]);

})();
