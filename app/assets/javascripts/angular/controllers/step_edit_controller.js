angular.module('app').controller('StepEditCtrl', ['$scope', '$http', '$location', 'Manual', 'Step', 'Block', 'Markdowns', 'Images', 'Videos', 'imgur', function ($scope, $http, $location, Manual, Step, Block, Markdowns, Images, Videos, imgur)
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
            alert(JSON.stringify(obj));
        });
        // alert($scope.image);
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

    $scope.parseYoutubeUrl = function youtube_parser(url){
        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
        var match = url.match(regExp);
        return (match&&match[7].length==11)? match[7] : false;
    }

    $scope.addVideo = function () {
        var url = prompt('Youtube link', "");
        var parsedData = $scope.parseYoutubeUrl(url);
        if (parsedData == false)
        {
            alert('Invalid link');
            return;
        }

        var video = new Block();
        video.content = parsedData;
        video.priority = $scope.list.length + 1;
        video.step_id = $scope.step.id;
        Videos.create(video, function(response) {
            Block.get({id: response.id}).$promise.then(function (result) {
                $scope.list.push(result);
            });
        });
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
