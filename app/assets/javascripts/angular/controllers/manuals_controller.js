var app = angular.module('manualApp', ['ui.sortable'])
    .controller('PageListCtrl', ['$scope', PageListCtrl]);

function PageListCtrl($scope)
{
    var tmpList = [];
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

    $scope.addPage = function() {
        $scope.list.push({ "id":0, "priority": list.length + 1, "manual_id":1 });
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

//      $scope.addPage = function() {
//          alert('TODO: ADD');
////                pagesList.todos.push({ text: pagesList.todoText, done: false });
////                pagesList.todoText = '';
//      };


//            pagesList.remaining = function() {
//                var count = 0;
//                angular.forEach(todoList.todos, function(todo) {
//                    count += todo.done ? 0 : 1;
//                });
//                return count;
//            };

//            pagesList.remove = function() {
//                var oldTodos = todoList.todos;
//                todoList.todos = [];
//                angular.forEach(oldTodos, function(todo) {
//                    if (!todo.done) todoList.todos.push(todo);
//                });
//            };

}


app.directive('sortable', function ($timeout) {
    return function ($scope, element, attributes) {
        element.sortable({
            stop : function(event, ui) {
                $scope.$apply(function () {
                    $scope.updateOrder(element)
                    $scope.syncOrder(element.sortable('toArray'));
                });
            }
        });
    };
});