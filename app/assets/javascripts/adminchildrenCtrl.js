/* global angular */
(function() {
  angular.module('app').controller('adminchildrenCtrl',
    function($scope, $http) {
      $http.get('api/v1/children.json').then(function(response) {
        $scope.children = response.data;
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

      $scope.updateStatus = function(status, id) {
        var params = {
          id: id,
          accepted: status
        };

        $http.patch('api/v1/children.json', params).then(function(response) {
          $scope.children.push(response.data);
          $scope.alerts.push({type: 'success', msg: 'Well done! You successfully updated the acceptance of this child.'});
        });
      };

      $scope.deleteChild = function(id) {

        $http.delete('api/v1/children/'+ id +'.json').then(function(response) {

          $scope.alerts.push({type: 'success', msg: 'Well done! You successfully deleted the child.'});
        });
      };

      $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
      };

      window.$scope = $scope;
    });
})();