/* global angular */
(function() {
  angular.module('app').controller('adminCtrl',
    function($scope, $http) {
      $http.get('api/v1/users.json').then(function(response) {
        $scope.users = response.data;
      });

      $scope.setOrderAttribute = function(inputAttribute) {
        inputAttribute === "oldToNew" ? $scope.isOrderDescending = false : inputAttribute === "newToOld" ? $scope.isOrderDescending = !$scope.isOrderDescending : $scope.isOrderDescending = '';
        
        if ($scope.isOrderDescending != '') {
          $scope.orderAttribute = 'id';
        } else {
          $scope.orderAttribute = undefined;
        };
        
      };

      $scope.alerts = [];

      $scope.updateType = function(type, id) {
        var params = {
          id: id,
          user_type: type
        };

        $http.patch('api/v1/users.json', params).then(function(response) {
          $scope.users.push(response.data);
          $scope.alerts.push({type: 'success', msg: 'Well done! You successfully changed the user type.'});
        });
      };

      $scope.deleteUser = function(id) {

        $http.delete('api/v1/users/'+ id +'.json').then(function(response) {

          $scope.alerts.push({type: 'success', msg: 'Well done! You successfully deleted the user.'});
        });
      };

      $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
      };

      window.$scope = $scope;
    });
})();