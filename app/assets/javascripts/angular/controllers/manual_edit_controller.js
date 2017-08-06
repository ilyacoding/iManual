angular.module('app').controller('ManualEditCtrl', ['$scope', '$http', 'Manual', 'Categories', 'Step', 'Steps', 'Tags', 'imgur', function ($scope, $http, Manual, Categories, Step, Steps, Tags, imgur)
{
    $scope.form = {
        state: {},
        data: {}
    };

    $scope.loading = false;

    $scope.initializeManual = function(manualId) {
        $scope.manual = Manual.get({id: manualId});
        $scope.categories = Categories.get();

        $scope.manual.$promise.then(function (result)
        {
            $scope.list = result.steps;
            $scope.form.data.name = result.name;
            $scope.form.data.category_id = result.category_id;
            $scope.form.data.tags = result.tags;
        });

        $scope.categories.$promise.then(function (result) {
            $scope.category = $scope.manual.category_id;
        });
    };

    $scope.saveForm = function() {
        $scope.manual.name = $scope.form.data.name;
        $scope.manual.category_id = $scope.form.data.category_id;
        $scope.manual.tags = $scope.form.data.tags;
        $scope.updateManual();
    };

    $scope.updateManual = function () {
        Manual.update({ id: $scope.manual.id }, $scope.manual);
    };

    $scope.addStep = function(formData) {
        if (formData.stepName.length > 0)
        {
            var step = new Step();
            step.name = formData.stepName;
            formData.stepName = "";
            step.priority = $scope.list.length + 1;
            Steps.create({ manual_id: $scope.manual.id }, step, function(response) {
                Step.get({ manual_id: $scope.manual.id, id: step.priority }).$promise.then(function (result) {
                    $scope.list.push(result);
                });
            });
        }
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

    $scope.uploadImage = function(event) {
        var files = event.target.files;
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            if(!$scope.isValidImage(file.type)) {
                return;
            }
            $scope.loading = true;
            imgur.upload(file).then(function then(model) {
                $scope.manual.preview = model.link;
                $scope.updateManual();
                $scope.loading = false;
            });
        }
    };

    $scope.isValidImage = function (fileType) {
        var allowedExtension = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/bmp'];
        for(var index in allowedExtension) {

            if(fileType === allowedExtension[index]) {
                return true;
            }
        }
        return false;
    };

    $scope.loadTags = function(query) {
        return $http.get('/tags.json?query=' + query);
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

    $scope.syncPositions = function (priority) {
        $scope.list.forEach(function(obj) {
            if (obj.priority > priority) {
                obj.priority -= 1;
            }
        });
    };

    $scope.updateOrderBackend = function () {
        $scope.list.forEach(function (obj) {
            Step.update({ manual_id: $scope.manual.id, id: obj.id }, obj, function (response) {});
        });
    }
}]);
