angular.module('app').controller('ManualEditCtrl', ['$scope', '$http', 'Manual', 'Categories', 'Step', 'Steps', 'Tags', 'imgur', function ($scope, $http, Manual, Categories, Step, Steps, Tags, imgur)
{
    $scope.loading = false;

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
            // alert(JSON.stringify(obj));
        });
        alert(JSON.stringify($scope.manual));
    };

    $scope.loadTags = function(query) {
        return $http.get('/tags.json?query=' + query);
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
            alert(JSON.stringify(step));
            Steps.create({ manual_id: $scope.manual.id }, step, function(response) {
                Step.get({ manual_id: $scope.manual.id, id: step.priority }).$promise.then(function (result) {
                    $scope.list.push(result);
                });
            });
        }
    };

    $scope.imageUpload = function(event){
        var files = event.target.files;
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var fileType = file.type;
            var allowedExtension = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/bmp'];
            var isValidFile = false;
            for(var index in allowedExtension) {

                if(fileType === allowedExtension[index]) {
                    isValidFile = true;
                    break;
                }
            }
            if(!isValidFile) {
                alert('Only images allowed');
                return;
            }
            $scope.loading = true;
            imgur.upload(file).then(function then(model) {
                $scope.loading = false;
                $scope.manual.preview = model.link;
                $scope.updateManual();
                alert(JSON.stringify($scope.manual));
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
