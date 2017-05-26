/*
 * SearchMapController - the controller for search map in family_center view
 */
(function() {
  'use strict';
  angular.module('app').controller('MapSearchController',
      ['$scope','$http', '$httpParamSerializerJQLike', '$timeout',

  function($scope, $http, $httpParamSerializerJQLike, $timeout) {
    $scope.query = {};
    $scope.data = [];
    $scope.map;
    $scope.searchResults = "";
    $scope.markers = [];

    // delay loading of google map
    $timeout(function() {
        var uluru = {lat: 41.0906369, lng: -85.0814343};
        $scope.map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: uluru
        });
    }, 100)

    function createPhysicianMarker(latlng, firstname, lastname, address, state, city, zipcode, specialty, showPage) {
          var marker = new google.maps.Marker({
            map: $scope.map,
            position: latlng,
            title: firstname,
          });
          $scope.markers.push(marker);
          google.maps.event.addListener(marker, 'click', function() {
              var contentString = '<div id="content">'+
              '<div id="siteNotice">'+
              '</div>'+
              '<h2 id="firstHeading" class="firstHeading">'+firstname+' '+lastname+'</h2>'+
              '<div id="bodyContent">'+
              '<p><b>Address: </b><br>'+
              address+'<br>'+
              city+', '+
              state+' '+
              zipcode+'</p>'+
              '<p><b>Specialty:</b> '+specialty+'<br>'+
              '<a href='+showPage+'>More info</a></p>'+
              '</div>'+
              '</div>';
              $scope.infoWindow.setContent(contentString);
              $scope.infoWindow.open($scope.map, marker);
            });
      }


      function createFamilyMarker(latlng, lastname, address, state, city, trisomy, showPage) {
        var marker = new google.maps.Marker({
          map: $scope.map,
          position: latlng,
          title: lastname,
        });
        $scope.markers.push(marker);
        google.maps.event.addListener(marker, 'click', function() {
            var contentString = '<div id="content">'+
            '<div id="siteNotice">'+
            '</div>'+
            '<h2 id="firstHeading" class="firstHeading"> '+ lastname +'</h2>'+
            '<div id="bodyContent">'+
            '<p><b>Address: </b><br>'+
            address+'<br>'+
            city+', '+
            state+' '+ '<br>'+
            "trisomy type: "+ trisomy+ '<br>'+
            '<a href='+showPage+'>View Family Page</a>'+
            '</div>'+
            '</div>';
            $scope.infoWindow.setContent(contentString);
            $scope.infoWindow.open($scope.map, marker);
          });
      }


    function displayMarkers() {
        // loop through data array
        if ($scope.query.type === "physician") {
        for(var i = 0; i < $scope.data["data"].length; i++) {
            var latlng = new google.maps.LatLng($scope.data["data"][i]["attributes"]["latitude"], $scope.data["data"][i]["attributes"]["longitude"] );
            console.log(latlng);
            var firstname = $scope.data["data"][i]["attributes"]["first-name"];
            var lastname = $scope.data["data"][i]["attributes"]["last-name"];
            var address = $scope.data["data"][i]["attributes"]["address"];
            var state = $scope.data["data"][i]["attributes"]["state"];
            var city = $scope.data["data"][i]["attributes"]["city"];
            var zipcode = $scope.data["data"][i]["attributes"]["zip-code"];
            var showPage = $scope.data["data"][i]["attributes"]["self-url"];
            var specialty = $scope.data["data"][i]["attributes"]["specialty"]
            createPhysicianMarker(latlng, firstname, lastname, address, state, city, zipcode, specialty, showPage);
        }
      }
      else if ($scope.query.type === "family") {
        console.log($scope.data[0].state)
        for(var i = 0; i < $scope.data.length; i++) {
            var latlng = new google.maps.LatLng($scope.data[i]["latitude"], $scope.data[i]["longitude"] )
            var lastname = $scope.data[i]["family_name"];
            var address = $scope.data[i]["street_address"];
            var state = $scope.data[i]["state"];
            var city = $scope.data[i]["city"];
            var trisomy = $scope.data[i]["trisomy_type"];
            var showPage = "/families/" + $scope.data[i]["id"];
            createFamilyMarker(latlng, lastname, address, state, city, trisomy, showPage);
        }
      }
    }


    $scope.initializeMap = function() {
        $scope.infoWindow = new google.maps.InfoWindow(); // set global infoWindow
        google.maps.event.addListener($scope.map, 'click', function() {
          $scope.infoWindow.close();
        });
        displayMarkers();
    }



    function removeMarkers() {
        for (var i = 0; i < $scope.markers.length; i++) {
            // remove marker from map
            $scope.markers[i].setMap(null);
        }
        // empty markers list
        $scope.markers = [];
    }


    $scope.performSearch = function() {
        // send ajax only if form has changed
        if ($scope.search_form.$dirty) {
            var url = "/api/v1/search?" + $httpParamSerializerJQLike($scope.query);
            $http({
                method: 'GET',
                url: url
            }).then(function successCallback(response) {
                  $scope.data = response.data;
                  removeMarkers(); // for future searches
                  $scope.search_form.$setPristine(); // set to false
                  $scope.initializeMap();

        }, function errorCallback(response) {
            $scope.searchResults = "No results matched.";
            });
        };
     }

    window.$scope = $scope;

  }]);

})();