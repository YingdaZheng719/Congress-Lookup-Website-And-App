

angular.
    module('favoriteBillsTable').
    component('favoriteBillsTable', {
        templateUrl: 'favorite-bills-table/favorite-bills-table.template.html',
        controller: ['$scope', '$http', 'mySharedService',
            function FavoriteBillsTableController($scope, $http, mySharedService) {
                
                $scope.billList = mySharedService.billList;
                
                $scope.addBill = function addBill(bill_id) {
                    mySharedService.addBill(bill_id); 
                }
                
                $scope.removeBill = function removeBill(bill_id) {
                    mySharedService.removeBill(bill_id); 
                }
                
            }
        ]
        
    });
