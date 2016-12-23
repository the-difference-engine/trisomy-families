/* global angular */
angular.module("app").controller('queriesCtrl', function($scope, $http) {
 
//Define the `myDataSource` scope variable.
  var children = $http.get('/api/v1/children.json');
  $scope.myDataSource = {
    chart: {
      caption: "Trisomy Tables",
      numberPrefix: "$",
      theme: "fint"
    },

    data:[{
      label: children['state'],
      value: "880000"
    },
    {
      label: "Garden Groove harbour",
      value: "730000"
    },
    {
      label: "Los Angeles Topanga",
      value: "590000"
    },
    {
      label: "Compton-Rancho Dom",
      value: "520000"
    },
    {
      label: "Daly City Serramonte",
      value: "330000"
    }]
  };
});