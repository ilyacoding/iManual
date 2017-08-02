angular.module('app').controller('ManualEditCtrl', ['$scope', 'Manual', 'Categories', 'Step', 'Steps', function ($scope, Manual, Categories, Step, Steps)
{
    $scope.getManual = function(manualId) {
        $scope.manual = Manual.get({id: manualId});
        $scope.categories = Categories.get();

        $scope.manual.$promise.then(function (result)
        {
            $scope.list = result.steps;
            $scope.form.data.text = result.name;
        });

        $scope.categories.$promise.then(function (result) {
            $scope.category = $scope.manual.category_id;
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
        $scope.updateManual();
    };

    $scope.updateManual = function () {
        Manual.update({ id: $scope.manual.id }, $scope.manual);
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
            Steps.create({ manual_id: $scope.manual.id }, step, function(response) {
                Step.get({ manual_id: $scope.manual.id, id: step.priority }).$promise.then(function (result) {
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
        Step.delete({ manual_id: $scope.manual.id, id: priority }, function () {
            $scope.list.splice(index, 1);
            $scope.syncPositions(priority);
            $scope.updateOrderBackend();
        });
    };

    $scope.updateOrderBackend = function () {
        $scope.list.forEach(function (obj) {
            Step.update({ manual_id: $scope.manual.id, id: obj.id }, obj, function (response) {});
        });
    }
}]);
