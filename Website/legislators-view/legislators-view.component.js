angular.
    module('legislatorsView').
    component('legislatorsView', {
        templateUrl: 'legislators-view/legislators-view.template.html',
        controller: ['$scope',
            function legislatorsController($scope) {
                $('#nav_secondary li:eq(0)').click(function (e) {
                  e.preventDefault();
                  $('#nav_secondary li').className = '';
                  $('#nav_secondary li:eq(0)').className = "active";
                });

                $('#nav_secondary li:eq(1)').click(function (e) {
                  e.preventDefault();
                  $('#nav_secondary li').className = '';
                  $('#nav_secondary li:eq(1)').className = "active";
                });

                $('#nav_secondary li:eq(2)').click(function (e) {
                  e.preventDefault();
                  $('#nav_secondary li').className = '';
                  $('#nav_secondary li:eq(2)').className = "active";
                });
            }
        ]
    });