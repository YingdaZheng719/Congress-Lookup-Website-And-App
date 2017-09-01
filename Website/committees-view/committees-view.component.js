angular.
    module('committeesView').
    component('committeesView', {
        templateUrl: 'committees-view/committees-view.template.html',
        controller: ['$scope',
            function committeesController($scope) {
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