/* angular */
(function(){
  angular.module('app').controller('calendarCtrl', function($scope, $http) {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $scope.events = [];

    $scope.setUp = function() {
      $http.get('/api/v1/events').then(function(response) {
        console.log(JSON.stringify(response.data));
        for(var i = 0; i < response.data.length; i++) {
          $scope.events.push(response.data[i]);
        }
      })
    };


    $scope.eventSources = [$scope.events];
    window.$scope = $scope;
  })
})();
