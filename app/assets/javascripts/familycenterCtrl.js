/* angular */
(function() {
  angular.module('app').controller('familycenterCtrl', ['$scope','$http', '$httpParamSerializerJQLike', '$timeout', function($scope, $http, $httpParamSerializerJQLike, $timeout) {

    $scope.data = [];
    // $scope.markers = [];
    $scope.map;
    $scope.searchResults = "";

    $timeout(function() {
      var uluru = {lat: 41.0906369, lng: -85.0814343};
      $scope.map = new google.maps.Map(document.getElementById('map'), {
        zoom: 4,
        center: uluru
      });
    }, 100);


    $scope.createMarker = function(latlng, firstname, lastname, address, state, city, zipcode, link) {
      var marker = new google.maps.Marker({
        map: $scope.map,
        position: latlng,
        title: firstname,
      });

      google.maps.event.addListener(marker, 'click', function() {

        var contentString = '<div id="content">'+
        '<div id="siteNotice">'+
        '</div>'+
        '<h2 id="firstHeading" class="firstHeading">' + firstname + ' ' + lastname + '</h2>'+
        '<div id="bodyContent">'+
        '<p><b>Address: </b><br>'+
        address+'<br>'+
        city+', '+
        state+' '+
        zipcode+'</p><br>'+
        '<a href=' + link+'>Website</a>'+
        '</div>'+
        '</div>';

        infoWindow.setContent(contentString);

        infoWindow.open($scope.map, marker);
        // $scope.markers.push(marker);
      });
    };


    $scope.displayMarkers = function() {

      for(var i = 0; i < $scope.data["data"].length; i++) {

        var latlng = new google.maps.LatLng($scope.data["data"][i]["attributes"]["longitude"], $scope.data["data"][i]["attributes"]["latitude"] )
        var firstname = $scope.data["data"][i]["attributes"]["first-name"];
        var lastname = $scope.data["data"][i]["attributes"]["last-name"];
        var address = $scope.data["data"][i]["attributes"]["address"];
        var state = $scope.data["data"][0]["attributes"]["state"];
        var city = $scope.data["data"][0]["attributes"]["city"];
        var zipcode = $scope.data["data"][0]["attributes"]["zip-code"];
        var link = $scope.data["data"][0]["attributes"]["link"]

        $scope.createMarker(latlng, firstname, lastname, address, state, city, zipcode, link);

      }

    };


    $scope.initializeMap = function() {
      infoWindow = new google.maps.InfoWindow();

      google.maps.event.addListener($scope.map, 'click', function() {
        infoWindow.close();
      });
      $scope.displayMarkers();
    };


    $scope.performSearch = function() {
      var url = "/api/v1/search?" + $httpParamSerializerJQLike($scope.query);

      $http({
          method: 'GET',
          url: url

      }).then(function(response) {
        $scope.data = response.data;
        $scope.searchResults = response.data["data"].length + ' results';
        $scope.initializeMap();
      });
    };

    window.$scope = $scope;

  }]);

})();
