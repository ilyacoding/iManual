app.controller('PagesController', function($scope, Page, $routeParams) {
    
    $scope.pages = Page.query({
        manualId: $routeParams.id
    });

    $scope.save = function() {
        var obj = new Page({
            priority: 0,
            manualId: $routeParams.id
        });

        obj.$save(function(response) {
            $scope.pages.unshift(response);
        }, function(response) {
            $scope.errors = response.data.errors;
        });
    }
});