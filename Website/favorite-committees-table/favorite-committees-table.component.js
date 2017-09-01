

angular.
    module('favoriteCommitteesTable').
    component('favoriteCommitteesTable', {
        templateUrl: 'favorite-committees-table/favorite-committees-table.template.html',
        controller: ['$scope', '$http', 'mySharedService',
            function FavoriteCommitteesTableController($scope, $http, mySharedService) {
                
                $scope.committeeList = mySharedService.committeeList;
                
                $scope.addCommittee = function addCommittee(committee_id) {
                    mySharedService.addCommittee(committee_id); 
                }
                
                $scope.removeCommittee = function removeCommittee(committee_id) {
                    mySharedService.removeCommittee(committee_id); 
                }

            }
        ]
        
    });