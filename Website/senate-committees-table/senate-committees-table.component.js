angular.
    module('senateCommitteesTable').
    component('senateCommitteesTable', {
        templateUrl: 'senate-committees-table/senate-committees-table.template.html',
        controller: ['$scope', '$http', 'mySharedService', 
            function SenateCommitteesController($scope, $http, mySharedService) {
                
                $scope.committees = [];
                getResultsPage();
                
                //an array stores info about favorite status of every committee
                $scope.committee_favorite = {};
                
                function getResultsPage() {
                    
                   $http.get('http://104.198.0.197:8080/committees?apikey=c79690decb8142c78f0a5e463dfecdf0&chamber=senate&per_page=all')
                    .then(function(response) {
                        $scope.committees = response.data.results;
                        //set committee_favorite
                        $scope.committees.forEach(function(committee) {
                            if(get_favor_status(committee.committee_id)) {
                                $scope.committee_favorite[committee.committee_id] = "yellow"
                            } else {
                                $scope.committee_favorite[committee.committee_id] = "white"
                            }
                        });
                    }); 
                }
                
                //change favorite status
                $scope.changeFavorite = function changeFavorite(committee_id) {
                    if($scope.committee_favorite[committee_id] == "yellow") {
                        mySharedService.removeCommittee(committee_id);
                        $scope.committee_favorite[committee_id] = "white";
                    } else {
                        mySharedService.addCommittee(committee_id);
                        $scope.committee_favorite[committee_id] = "yellow";
                    }
                }
                
                function get_favor_status(committee_id) {
                    return mySharedService.is_favorite_committee(committee_id);
                }
            }
        ]
        
    });
