/* global angular */
(function() {
  angular.module('app').controller('familyCtrl',
    function($scope, $http) {
      $http.get('/api/v1/families/children.json').then(function(response) {
        $scope.children = response.data;
      });
      $http.get('/api/v1/families.json').then(function(response) {
        $scope.family = response.data[0];
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

      $scope.deleteChild = function(id) {

        $http.delete('api/v1/users/'+ id +'.json').then(function(response) {

          $scope.alerts.push({type: 'success', msg: 'Well done! You successfully deleted the child.'});
        });
      };

      $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
      };

      window.$scope = $scope;
    });
})();