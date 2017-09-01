

angular.
    module('favoriteLegislatorsTable').
    component('favoriteLegislatorsTable', {
        templateUrl: 'favorite-legislators-table/favorite-legislators-table.template.html',
        controller: ['$scope', '$http', 'mySharedService', 
            function FavoriteLegislatorsTableController($scope, $http, mySharedService) {
                
                $scope.legislatorList = mySharedService.legislatorList;
                
                
                $scope.addLegislator = function addLegislator(bioguide_id) {
                    mySharedService.addLegislator(bioguide_id); 
                }
                
                $scope.removeLegislator = function removeLegislator(bioguide_id) {
                    mySharedService.removeLegislator(bioguide_id); 
                }
                

            }
        ]
        
    });
