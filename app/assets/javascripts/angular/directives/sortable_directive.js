angular.module('app').directive('sortable', sortable);

sortable.$inject = ['$timeout'];

function sortable($timeout) {
    return function ($scope, element, attributes) {
        element.sortable({
            stop : function(event, ui) {
                $scope.$apply(function () {
                    $scope.syncOrder(element.sortable('toArray'));
                });
            }
        });
    };
}
