angular.
    module('billsView').
    component('billsView', {
        templateUrl: 'bills-view/bills-view.template.html',
        controller: ['$scope',
            function billsController($scope) {
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

            }
        ]
    });