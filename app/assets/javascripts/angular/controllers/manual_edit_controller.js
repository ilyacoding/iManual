angular.module('app').controller('ManualEditCtrl', ['$scope', 'Manual', 'Step', 'Steps', function ($scope, Manual, Step, Steps)
{
    $scope.getManual = function(manualId) {
        $scope.manual = Manual.get({id: manualId});

        $scope.manual.$promise.then(function (result) {
            $scope.list = result.steps;
            $scope.form.data.text = result.name;
        });
    };

    $scope.cl = function () {
        $scope.list.forEach(function (obj) {
            alert(JSON.stringify(obj));
        });
    };

    $scope.form = {
        state: {},
        data: {}
    };

    $scope.saveForm = function() {
        $scope.manual.name = $scope.form.data.text;
        Manual.update({ id: $scope.manual["id"] }, $scope.manual);
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
        $scope.updateOrderBackend();
    };

    $scope.addStep = function(formData) {
        if (formData.name.length > 0)
        {
            var step = new Step();
            step.name = formData.name;
            formData.name = "";
            step.priority = $scope.list.length + 1;
            step.manual_id = $scope.manual.id;
            Steps.create(step, function(response) {
                Step.get({id: response.id}).$promise.then(function (result) {
                    $scope.list.push(result);
                });
            });
        }
    };

    $scope.syncPositions = function (priority) {
        $scope.list.forEach(function(obj)
        {
            if (obj.priority > priority)
            {
                obj.priority -= 1;
            }
        });
    };

    $scope.deleteStep = function(item) {
        var index = $scope.list.indexOf(item);
        var priority = item.priority;
        Step.delete({id: $scope.list[index].id}, function () {
            $scope.list.splice(index, 1);
            $scope.syncPositions(priority);
            $scope.updateOrderBackend();
        });
    };

    $scope.updateOrderBackend = function () {
        $scope.list.forEach(function (obj) {
            Step.update({ id: obj.id }, obj, function (response) {});
        });
    }
}]);
