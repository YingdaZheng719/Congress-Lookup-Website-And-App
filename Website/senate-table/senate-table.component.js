
angular.
    module('senateTable').
    component('senateTable', {
        templateUrl: 'senate-table/senate-table.template.html',
        controller: ['$scope', '$http',
            function ByStateTableController($scope, $http) {
                
                $scope.legislators = [];
                $scope.totalLegislators = 0;
                getResultsPage();
                
                function getResultsPage() {
                    
                   $http.get('http://104.198.0.197:8080/legislators?apikey=c79690decb8142c78f0a5e463dfecdf0&chamber=senate&per_page=all')
                    .then(function(response) {
                        $scope.legislators = response.data.results;
                        $scope.totalLegislators = response.data.count;

                    }); 

                }
                
                // choose img according to the party property
                $scope.party_img = function party_img(party) {
                    if(party == "R") {
                         return "Republican";
                     } else {
                         return "Democrat";
                     }
                }
                
            }
        ]
        
    });