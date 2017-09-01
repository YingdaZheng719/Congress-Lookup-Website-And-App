angular.
  module('congressApp').
  config(['$locationProvider', '$routeProvider',
    function config($locationProvider, $routeProvider) {
      $locationProvider.hashPrefix('!');

      $routeProvider.
        when('/legislators', {
          template: '<legislators-view></legislators-view>'
        }).
        when('/bills', {
          template: '<bills-view></bills-view>'
        }).
        when('/committees', {
          template: '<committees-view></committees-view>'
        }).
        when('/favorite', {
          template: '<favorite-view></favorite-view>'
        }).
        when('/legislator-details/:bioguide_id', {
          template: '<legislator-details></legislator-details>'
        }).
        when('/bill-details/:bill_id', {
          template: '<bill-details></bill-details>'
        }).
        otherwise('/legislators');
    }
  ]);