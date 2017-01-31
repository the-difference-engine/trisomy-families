/* global angular */
angular.module("app").controller('adminCtrl', function($scope, $http) {
  $scope.setup = function() {
    $http.get('/api/v1/users.json').body;
  };

  $scope.createQuery = function(state, treatment, surgery, characteristic) {
    var params = {
      state: state,
      treatment: treatment,
      surgery: surgery,
      characteristic: characteristic
    };
  };
});