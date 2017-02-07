/* global angular */
angular.module("app").controller('ChildrenSearchController', ['$scope', '$http', function($scope, $http) {
  $scope.data = [];
  $scope.setUp = function() {
      $http.get('/api/v1/children.json').then(function successCallback(response) {
            $scope.data = response.data;
          },
          function errorCallback(response) {
              console.log("Error on set-up");
    });
  };

  $scope.createQuery = function(state, treatment, surgery, characteristic) {
    var params = {
      state: state,
      treatment: treatment,
      surgery: surgery,
      characteristic: characteristic
    };
  };

  window.$scope = $scope;
}]);
