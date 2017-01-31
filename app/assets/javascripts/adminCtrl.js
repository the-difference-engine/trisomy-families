/* global angular */
(function() {
  angular.module('app').controller('adminCtrl', function($scope, $http) {
    $http.get('api/v1/users.json').then(function(response) {
      $scope.users = response.data;
    });
    $scope.createType = function(type) {
      var params = {
        user_type: type,
      };
      $http.post('api/v1/users.json', params).then(function(response) {
        $scope.users.push(response.data);
      });
    };
    window.$scope = $scope;
  });
})();