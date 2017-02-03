/* global angular */
(function() {
  angular.module('app').controller('adminCtrl',
    function($scope, $http) {
      $http.get('api/v1/users.json').then(function(response) {
        $scope.users = response.data;
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

      $scope.updateType = function(type, id) {
        var params = {
          id: id,
          user_type: type
        };

        $http.patch('api/v1/users.json', params).then(function(response) {
          $scope.users.push(response.data);
          $scope.alerts.push({ type: 'success', msg: 'Well done! You successfully changed the user type.' });
        });
      };

      $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
      };

      window.$scope = $scope;
    });
})();