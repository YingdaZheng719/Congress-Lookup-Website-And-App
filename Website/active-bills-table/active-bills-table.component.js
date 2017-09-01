angular.
    module('activeBillsTable').
    component('activeBillsTable', {
        templateUrl: 'active-bills-table/active-bills-table.template.html',
        controller: ['$scope', '$http',
            function ActiveBillsTableController($scope, $http) {
                
                $scope.bills = [];
                $scope.totalBills = 0;
                getResultsPage();
                
                function getResultsPage() {
                    
                   $http.get('http://104.198.0.197:8080/bills?apikey=c79690decb8142c78f0a5e463dfecdf0&history.active=true&per_page=all')
                    .then(function(response) {
                        $scope.bills = response.data.results;
                        $scope.totalBills = response.data.count;

                    }); 

                }
                
            }
        ]
        
    });
