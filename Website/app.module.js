var congressApp = angular.module('congressApp', [
    'legislatorsView',
    'billsView',
    'committeesView',
    'favoriteView',
    'legislatorDetails',
    'billDetails',
    'ngRoute'
]);

angular.module('congressApp').factory('mySharedService', 
    ['$http', function($http) {
        
    var legislatorList = [];
    var billList = [];
    var committeeList = [];
     
    
    // ------------- add -----------------
    var addLegislator = function(bioguide_id) {
                    
        $http.get('http://104.198.0.197:8080/legislators?apikey=c79690decb8142c78f0a5e463dfecdf0&bioguide_id=' + bioguide_id)
            .then(function(response) {
                legislatorList.push(response.data.results[0]);
            });
    };
    var addBill = function(bill_id) {
                    
        $http.get('http://104.198.0.197:8080/bills?apikey=c79690decb8142c78f0a5e463dfecdf0&bill_id=' + bill_id)
            .then(function(response) {
                billList.push(response.data.results[0]);
            });
    };
    var addCommittee = function(committee_id) {
                    
        $http.get('http://104.198.0.197:8080/committees?apikey=c79690decb8142c78f0a5e463dfecdf0&committee_id=' + committee_id)
            .then(function(response) {
                committeeList.push(response.data.results[0]);
            });
    };
    
        
    // ------------- remove -----------------    
    var removeLegislator = function(bioguide_id) {
        
        var index = -1;
        for(var i=0; i < legislatorList.length; i++) {
            if(legislatorList[i].bioguide_id == bioguide_id) {
                index = i;
                break;
            }
        }
        if(index >= 0) {
            legislatorList.splice(index, 1);
        }

    };
    var removeBill = function(bill_id) {
        
        var index = -1;
        for(var i=0; i < billList.length; i++) {
            if(billList[i].bill_id == bill_id) {
                index = i;
                break;
            }
        }
        if(index >= 0) {
            billList.splice(index, 1);
        }

    };
    var removeCommittee = function(committee_id) {
        
        var index = -1;
        for(var i=0; i < committeeList.length; i++) {
            if(committeeList[i].committee_id == committee_id) {
                index = i;
                break;
            }
        }
        if(index >= 0) {
            committeeList.splice(index, 1);
        }

    };
        
    // ------------- is_favorite -----------------    
    var is_favorite_legislator = function(bioguide_id) {
        var index = -1;
        for(var i=0; i < legislatorList.length; i++) {
            if(legislatorList[i].bioguide_id == bioguide_id) {
                index = i;
                break;
            }
        }
        if(index >= 0) {
            return true;
        } else {
            return false;
        }
    }
    var is_favorite_bill = function(bill_id) {
        var index = -1;
        for(var i=0; i < billList.length; i++) {
            if(billList[i].bill_id == bill_id) {
                index = i;
                break;
            }
        }
        if(index >= 0) {
            return true;
        } else {
            return false;
        }
    }
    var is_favorite_committee = function(committee_id) {
        var index = -1;
        for(var i=0; i < committeeList.length; i++) {
            if(committeeList[i].committee_id == committee_id) {
                index = i;
                break;
            }
        }
        if(index >= 0) {
            return true;
        } else {
            return false;
        }
    }
    // ------------- return -----------------
    return {
        legislatorList: legislatorList,
        billList: billList,
        committeeList: committeeList,
        
        addLegislator: addLegislator,
        addBill: addBill,
        addCommittee: addCommittee,
        
        removeLegislator: removeLegislator,
        removeBill: removeBill,
        removeCommittee: removeCommittee,
        
        is_favorite_legislator: is_favorite_legislator,
        is_favorite_bill: is_favorite_bill,
        is_favorite_committee: is_favorite_committee
    };
}]);

//{"bioguide_id":"F000444","in_office":true,"thomas_id":"01633","govtrack_id":"400134","crp_id":"N00009573","fec_ids":["H0AZ01184","S2AZ00141"],"first_name":"Jeff","nickname":null,"last_name":"Flake","middle_name":null,"name_suffix":null,"gender":"M","birthday":"1962-12-31","leadership_role":null,"term_start":"2013-01-03","term_end":"2019-01-03","state":"AZ","state_name":"Arizona","party":"R","title":"Sen","chamber":"senate","phone":"202-224-4521","fax":"202-226-4386","website":"http://www.flake.senate.gov","office":"413 Russell Senate Office Building","contact_form":"http://www.flake.senate.gov/contact.cfm","votesmart_id":28128,"icpsr_id":20100,"senate_class":1,"lis_id":"S358","state_rank":"junior","district":null,"oc_email":"Sen.Flake@opencongress.org","twitter_id":"JeffFlake","youtube_id":"flakeoffice","facebook_id":"senatorjeffflake","ocd_id":"ocd-division/country:us/state:az"}