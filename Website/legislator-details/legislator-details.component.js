angular.
    module('legislatorDetails').
    component('legislatorDetails', {
        templateUrl: 'legislator-details/legislator-details.template.html',
        controller: ['$scope', '$routeParams', '$http', 'mySharedService', '$window', 
            function legislatorsController($scope, $routeParams, $http, mySharedService, $window) {
                
                $scope.bioguide_id = $routeParams.bioguide_id;
                $scope.legislator_details = {};
                $scope.legislator_committees = {};
                $scope.legislator_bills = {};
                $scope.legislator_party = "";
                $scope.term_percetage = 0;
                getLegislatorDetails();
                
                $scope.legislator_favorite;
                get_favor_status();
                change_favor_style();
                     
                function getLegislatorDetails() {
                     $http.get('http://104.198.0.197:8080/legislators?apikey=c79690decb8142c78f0a5e463dfecdf0&bioguide_id=' + $scope.bioguide_id)
                        .then(function(response) {
                            $scope.legislator_details = response.data.results[0];
                         
                             if($scope.legislator_details.party == "R") {
                                 $scope.legislator_party = "Republican";
                             } else {
                                 $scope.legislator_party = "Democrat";
                             }
                            
                            //use momentJS for date calculation
                            var now = moment();
                            var term_start = moment($scope.legislator_details.term_start, 'YYYY-MM-DD');
                            var term_end = moment($scope.legislator_details.term_end, 'YYYY-MM-DD');
                            var term_since_start = now.diff(term_start, 'days');
                            var term_length = term_end.diff(term_start, 'days');
                            $scope.term_percetage = Math.round(term_since_start * 100 / term_length);
                     });
                    
                    $http.get('http://104.198.0.197:8080/committees?apikey=c79690decb8142c78f0a5e463dfecdf0&member_ids=' + $scope.bioguide_id)
                        .then(function(response) {
                            $scope.legislator_committees = response.data.results;

                     });
                    
                    $http.get('http://104.198.0.197:8080/bills?apikey=c79690decb8142c78f0a5e463dfecdf0&sponsor_id=' + $scope.bioguide_id)
                        .then(function(response) {
                            $scope.legislator_bills = response.data.results;

                     });
                }
                
                //momentJS for date calculation
                $scope.term_since_start = moment().format('YYYY-MM-DD');
                
                //change favorite status
                $scope.changeFavorite = function changeFavorite(bioguide_id) {
                    if($scope.legislator_favorite == true) {
                        mySharedService.removeLegislator(bioguide_id);
                        $scope.legislator_favorite = false;
                        change_favor_style();
                    } else {
                        mySharedService.addLegislator(bioguide_id);
                        $scope.legislator_favorite = true;
                        change_favor_style();
                    }
                }
                
                
                function get_favor_status() {
                    if(mySharedService.is_favorite_legislator($scope.bioguide_id) == true) {
                        $scope.legislator_favorite = true;
                    } else {
                        $scope.legislator_favorite = false;
                    }
                }
                
                
                function change_favor_style() {
                    if($scope.legislator_favorite == true) {
                        $('#favor_star_legislator').removeClass("white");
                        $('#favor_star_legislator').addClass("yellow");
                    } else {
                        $('#favor_star_legislator').removeClass("yellow");
                        $('#favor_star_legislator').addClass("white");
                    }
                }

                //window go back
                $scope.back = function back() {
                    $window.history.back();
                }
            }
        ]
    });