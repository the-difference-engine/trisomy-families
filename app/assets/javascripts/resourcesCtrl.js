/* global angular */
(function() {
  angular.module('app').controller('resourcesCtrl',
    function($scope, $http) {
      $http.get('/api/v1/resources.json').then(function(response) {
        $scope.resources = response.data;
      });

      $scope.setOrderAttribute = function(inputAttribute) {
        if (inputAttribute !== $scope.orderAttribute) {
          $scope.isOrderDescending = false;
        } else {
          $scope.isOrderDescending = !$scope.isOrderDescending;
        }
        $scope.orderAttribute = inputAttribute;
      };

      $scope.alerts = [];

      $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
      };

      window.$scope = $scope;
    });
})();