/* angular */
(function() {
  angular.module('app').controller('calendarCtrl', function($scope) {
    var date = new Date();
    var m = date.getMonth();
    var y = date.getFullYear();

    $scope.events = [{title: 'All Day Event',start: new Date(y, m, 1)}];

    $scope.eventSources = [$scope.events];
  });
})();
