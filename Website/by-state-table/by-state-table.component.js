

angular.
    module('byStateTable').
    component('byStateTable', {
        templateUrl: 'by-state-table/by-state-table.template.html',
        controller: ['$scope', '$http',
            function ByStateTableController($scope, $http) {
                
                $scope.legislators = [];
                $scope.totalLegislators = 0;
                $scope.legislatorsPerPage = 10;
                getResultsPage(1, "All States");
                
                $scope.pagination = {
                    current: 1
                };
                
                $scope.states = ["All States", 
                                 "Alabama", "Alaska", "Arizona", "Arkansas", "California", 
                                 "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", 
                                 "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", 
                                 "Kansas", "Kentucky", "Louisiana", "Maine","Maryland", 
                                 "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", 
                                 "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
                                 "New Mexico", "New York", "North Carolina","North Dakota", "Ohio", 
                                 "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", 
                                 "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
                                 "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
                                ];
                $scope.state = $scope.states[0];
                
                $scope.stateChanged = function(state) {
                    $scope.state = state;
                    getResultsPage(1, state);
                }
                
                $scope.pageChanged = function(newPage) {
                    getResultsPage(newPage, $scope.state);
                };
                
                function getResultsPage(pageNumber, state) {
                    if(state == "All States") {
                       $http.get('http://104.198.0.197:8080/legislators?apikey=c79690decb8142c78f0a5e463dfecdf0&per_page=' + $scope.legislatorsPerPage + '&page=' + pageNumber)
                        .then(function(response) {
                            $scope.legislators = response.data.results;
                            $scope.totalLegislators = response.data.count;
                            
                        }); 
                    } else {
                        $http.get('http://104.198.0.197:8080/legislators?apikey=c79690decb8142c78f0a5e463dfecdf0&per_page=' + $scope.legislatorsPerPage + '&page=' + pageNumber + '&state_name=' + state)
                        .then(function(response) {
                            $scope.legislators = response.data.results;
                            $scope.totalLegislators = response.data.count;
                            
                        });
                    }
                    
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


//http://104.198.0.197:8080/legislators
//https://congress.api.sunlightfoundation.com/legislators?chamber=house&state=WA&apikey=c79690decb8142c78f0a5e463dfecdf0
//apikey=c79690decb8142c78f0a5e463dfecdf0