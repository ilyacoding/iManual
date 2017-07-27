angular.module('app').directive('fileButton', function() {
    return {
        link: function(scope, element, attributes) {

            var el = angular.element(element);
            var button = el.children()[0];

            el.css({
                position: 'relative',
                overflow: 'hidden',
                width: button.offsetWidth,
                height: button.offsetHeight
            });

            var fileInput = angular.element('<input type="file" class="button" ng-model-instant onchange="angular.element(this).scope().imageUpload(event)" multiple />')
            fileInput.css({
                position: 'absolute',
                top: 0,
                left: 0,
                'z-index': '2',
                width: '100%',
                height: '100%',
                opacity: '0',
                cursor: 'pointer'
            });

            el.append(fileInput);
        }
    }
});

angular.module('app').directive('elastic', [
    '$timeout',
    function($timeout) {
        return {
            restrict: 'A',
            link: function($scope, element) {
                $scope.initialHeight = $scope.initialHeight || element[0].style.height;
                var resize = function() {
                    element[0].style.height = $scope.initialHeight;
                    element[0].style.height = "" + element[0].scrollHeight + "px";
                };
                element.on("input change", resize);
                $timeout(resize, 0);
            }
        };
    }
]);

angular.module('app').controller('StepEditCtrl', ['$scope', '$http', '$location', 'Step', 'Block', 'Markdowns', 'Images', 'imgur', function ($scope, $http, $location, Step, Block, Markdowns, Images, imgur)
{

    $scope.loading = false;

    $scope.getStep = function(stepId) {
        $scope.step = Step.get({id: stepId});

        $scope.step.$promise.then(function (result) {
            $scope.list = result.blocks;
        });
    };

    $scope.updateBlock = function (block) {
        var index = $scope.list.indexOf(block);
        Block.update({ id: block.id }, block, function (response) {});
    };

    $scope.cl = function () {
        $scope.list.forEach(function (obj) {
            // alert(JSON.stringify(obj));
        });
        alert($scope.image);
        // alert($scope.imageName);

    };

    $scope.updateName = function () {
        Step.update({ id: $scope.step.id }, $scope.step);
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

    $scope.imageUpload = function(event){
        var files = event.target.files;

        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            $scope.loading = true;
            imgur.upload(file).then(function then(model) {
                $scope.loading = false;
                $scope.addImage(model.link);
            });
        }
    };



    $scope.addText = function () {
        var markdown = new Block();
        markdown.content = "";
        markdown.priority = $scope.list.length + 1;
        markdown.step_id = $scope.step.id;
        Markdowns.create(markdown, function(response) {
            Block.get({id: response.id}).$promise.then(function (result) {
                $scope.list.push(result);
            });
        });
    };

    $scope.addImage = function (link) {
        var image = new Block();
        image.content = link;
        image.priority = $scope.list.length + 1;
        image.step_id = $scope.step.id;
        Images.create(image, function(response) {
            Block.get({id: response.id}).$promise.then(function (result) {
                $scope.list.push(result);
            });
        });
    };

    $scope.addVideo = function () {

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

    $scope.deleteBlock = function(block) {
        var index = $scope.list.indexOf(block);
        var priority = block.priority;
        Block.delete({id: block.id}, function () {
            $scope.list.splice(index, 1);
            $scope.syncPositions(priority);
            $scope.updateOrderBackend();
        });
    };

    $scope.updateOrderBackend = function () {
        $scope.list.forEach(function (obj) {
            Block.update({ id: obj.id }, obj, function (response) { });
        });
    }
}]);
