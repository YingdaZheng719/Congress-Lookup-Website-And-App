<!DOCTYPE html>
<html ng-app="congressApp">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <title>Congress App</title>
    <link href="external_module/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="app.css" rel="stylesheet">
  </head>
    
  <body class="container-fluid" style="padding:0">
    <!-- header -->
    <header>
        <div id="h_primary">
            <button type="button" id="nav_primary_toggle">
              <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
            </button>
            <h1><img src="images/logo.png"><span>Congress API</span></h1>
        </div>
    </header>
      
    <div class="table_container">
        <!----- nav ---->
        <div id="nav_primary" class="sidebar_table_cell">  <!--class="sidebar_toggle"-->
          <ul id="nav_primary_ul"> <!--class="sidebar_ul_toggle"-->
            <li> <!--class="sidebar_li_toggle"-->
                <a href="#!/legislators"><span class="glyphicon glyphicon-user"></span>
                    <span class="sidebar_tag">&nbsp;&nbsp;Legislators</span></a></li>
            <li> <!--class="sidebar_li_toggle"-->
                <a href="#!/bills"><span class="glyphicon glyphicon-file"></span>
                    <span class="sidebar_tag">&nbsp;&nbsp;Bills</span></a></li>
            <li> <!--class="sidebar_li_toggle"-->
                <a href="#!/committees"><span class="glyphicon glyphicon-log-in"></span>
                    <span class="sidebar_tag">&nbsp;&nbsp;Committees</span></a></li>
            <li> <!--class="sidebar_li_toggle"-->
                <a href="#!/favorite"><span class="glyphicon glyphicon-star"></span>
                    <span class="sidebar_tag">&nbsp;&nbsp;Favorites</span></a></li>
          </ul>
        </div>

        <!-- section -->  
        <div  id="sec_content" class="content_table_cell view-container"><!--class="content_toggle"-->
           <div ng-view class="view-frame"></div>
        </div>
    </div>
    
    
    <!-- script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="external_module/bootstrap/js/bootstrap.min.js"></script>
    <script src="external_module/angular.min.js"></script>
    <script src="external_module/angular-route.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.16.0/moment.min.js"></script>
    <script src="app.module.js"></script>
    <script src="app.config.js"></script>
    <script src="external_module/dirPagination.js"></script>
    <script src="legislators-view/legislators-view.module.js"></script>
    <script src="legislators-view/legislators-view.component.js"></script>
    <script src="by-state-table/by-state-table.module.js"></script>
    <script src="by-state-table/by-state-table.component.js"></script>
    <script src="house-table/house-table.module.js"></script>
    <script src="house-table/house-table.component.js"></script>
    <script src="senate-table/senate-table.module.js"></script>
    <script src="senate-table/senate-table.component.js"></script>
      
    <script src="bills-view/bills-view.module.js"></script>
    <script src="bills-view/bills-view.component.js"></script>
    <script src="active-bills-table/active-bills-table.module.js"></script>
    <script src="active-bills-table/active-bills-table.component.js"></script>
    <script src="new-bills-table/new-bills-table.module.js"></script>
    <script src="new-bills-table/new-bills-table.component.js"></script>
      
    <script src="committees-view/committees-view.module.js"></script>
    <script src="committees-view/committees-view.component.js"></script>
    <script src="house-committees-table/house-committees-table.module.js"></script>
    <script src="house-committees-table/house-committees-table.component.js"></script>
    <script src="senate-committees-table/senate-committees-table.module.js"></script>
    <script src="senate-committees-table/senate-committees-table.component.js"></script>
    <script src="joint-committees-table/joint-committees-table.module.js"></script>
    <script src="joint-committees-table/joint-committees-table.component.js"></script>
      
    <script src="favorite-view/favorite-view.module.js"></script>
    <script src="favorite-view/favorite-view.component.js"></script>
    <script src="favorite-legislators-table/favorite-legislators-table.module.js"></script>
    <script src="favorite-legislators-table/favorite-legislators-table.component.js"></script>
    <script src="favorite-bills-table/favorite-bills-table.module.js"></script>
    <script src="favorite-bills-table/favorite-bills-table.component.js"></script>
    <script src="favorite-committees-table/favorite-committees-table.module.js"></script>
    <script src="favorite-committees-table/favorite-committees-table.component.js"></script>
      
    <script src="legislator-details/legislator-details.module.js"></script>
    <script src="legislator-details/legislator-details.component.js"></script>
    <script src="bill-details/bill-details.module.js"></script>
    <script src="bill-details/bill-details.component.js"></script>
      
    <script src="app.js"></script>
  </body>
  
</html>