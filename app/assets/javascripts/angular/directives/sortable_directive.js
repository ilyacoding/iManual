angular.module('app').directive('sortable', function ($timeout) {
    return function ($scope, element, attributes) {
        element.sortable({
            stop : function(event, ui) {
                $scope.$apply(function () {
                    $scope.syncOrder(element.sortable('toArray'));
                });
            }
        });
    };
});
