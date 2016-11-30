/* angular */
(function() {
  angular.module('app').controller('familycenterCtrl', ['$scope','$http', '$httpParamSerializerJQLike', function($scope, $http, $httpParamSerializerJQLike) {

    $scope.data = [];

    $scope.setUp = function() {
      $http.get('/data').then(function(response) {
        $scope.data = response.data;
      });
    };

    $scope.performSearch = function() {
      // condition to find out which query was selected which affects the api endpoint needed
      $http({
          method: 'POST',
          url: '/api/v1/data',
          data: $httpParamSerializerJQLike($scope.query)
      });
    };

    window.$scope = $scope;

  }]);
})();
