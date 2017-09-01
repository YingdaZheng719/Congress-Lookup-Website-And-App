angular.
    module('billDetails').
    component('billDetails', {
        templateUrl: 'bill-details/bill-details.template.html',
        controller: ['$scope', '$routeParams', '$http', 'mySharedService', '$window',
            function billsController($scope, $routeParams, $http, mySharedService, $window) {
                
                $scope.bill_id = $routeParams.bill_id;
                $scope.bill_details = {};
                $scope.bill_status = "inactive";
                getBillDetails();
                
                $scope.bill_favorite;
                get_favor_status();
                change_favor_style();
                     
                function getBillDetails() {
                     $http.get('http://104.198.0.197:8080/bills?apikey=c79690decb8142c78f0a5e463dfecdf0&bill_id=' + $scope.bill_id)
                        .then(function(response) {
                            $scope.bill_details = response.data.results[0];
                         
                            if($scope.bill_details.active == false) {
                                $scope.bill_status = "inactive";
                            } else {
                                $scope.bill_status = "active";
                            }
                            
                     });  
                    
                }
                
                //change favorite status
                $scope.changeFavorite = function changeFavorite(bill_id) {
                    if($scope.bill_favorite == true) {
                        mySharedService.removeBill(bill_id);
                        $scope.bill_favorite = false;
                        change_favor_style();
                    } else {
                        mySharedService.addBill(bill_id);
                        $scope.bill_favorite = true;
                        change_favor_style();
                    }
                }
                
                function get_favor_status() {
                    if(mySharedService.is_favorite_bill($scope.bill_id) == true) {
                        $scope.bill_favorite = true;
                    } else {
                        $scope.bill_favorite = false;
                    }
                }
                
                function change_favor_style() {
                    if($scope.bill_favorite == true) {
                        $('#favor_star_bill').removeClass("white");
                        $('#favor_star_bill').addClass("yellow");
                    } else {
                        $('#favor_star_bill').removeClass("yellow");
                        $('#favor_star_bill').addClass("white");
                    }
                }
                
                //window go back
                $scope.back = function back() {
                    $window.history.back();
                }

            }
        ]
    });