/* global angular */
angular.module("app").controller('BirthdaysController', ['$scope', '$http', function($scope, $http) {

  $scope.setUp = function() {
      $http.get('/api/v1/children.json').then(function successCallback(response) {
            $scope.data = response.data;
          },
          function errorCallback(response) {
              console.log("Error on set-up");
    });
  };

  window.$scope = $scope;
}]);