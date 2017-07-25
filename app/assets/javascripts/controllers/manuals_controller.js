app.controller('ManualEditCtrl', ['$scope', ManualEditCtrl]);

function ManualEditCtrl($scope)
{
    $scope.list = [
        { "id":10, "priority":1, "manual_id":1, "steps": [{ name: "Do good" }, { name: "Do next thing" }] },
        { "id":11, "priority":2, "manual_id":1, "steps": [{ name: "Do good 2" }, { name: "Do next thing 3" }] },
        { "id":12, "priority":3, "manual_id":1, "steps": [{ name: "Do good 3" }] }
    ];

    $scope.sortableOptions = {
        cursor: "move",
        update: function (e, ui) {
            var $list = ui.item.parent();
            $scope.$apply(function () {
                $scope.currSort = $list.sortable("toArray")

            })
        }
    };

    $scope.syncOrder = function (elemPositions) {
        $scope.list.forEach(function (obj) {
            elemPositions.forEach(function (elemId, index) {
                var id = parseInt(elemId.replace(/object-/, ''));
                if (id === obj.id) {
                    obj.priority = index + 1;
                }
            });
        });
    };

    $scope.addStep = function() {
        $scope.list.push({ "id":0, "priority": $scope.list.length + 1, "manual_id":1 });
    };

    $scope.syncPositions = function () {
        var i = 1;
        $scope.list.forEach(function(obj)
        {
            obj.priority = i++;
        });
    };

    $scope.deletePage = function(index) {
        $scope.list.splice(index, 1);
        $scope.syncPositions();
    };

    $scope.updateOrder = function (element) {
        $scope.syncOrder(element.sortable('toArray'));
    };
}
