/* global angular */
angular.module("app").controller('queriesCtrl', function($scope, $http) {
 
//Define the `myDataSource` scope variable.
  var children = $http.get('/api/v1/children.json');
  $scope.myDataSource = {
    chart: {
      caption: "Harry's SuperMart",
      subCaption: "Top 5 stores in last month by revenue",
      numberPrefix: "$",
      theme: "fint"
    },

    for (var i = 0; i < children.length; i++) {
    label: children['state'];
    value: children['trisomy_type'];
    
    }

    data:[{
      label: "Bakersfield Central",
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