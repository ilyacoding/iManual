angular.module('app').controller('StepEditCtrl', ['$scope', '$http', '$location', 'Manual', 'Step', 'Block', 'Textes', 'Images', 'Videos', 'imgur', function ($scope, $http, $location, Manual, Step, Block, Textes, Images, Videos, imgur)
{
    $scope.form = {
        state: {},
        data: {}
    };

    $scope.loading = false;

    $scope.initializeStep = function(stepId, manualId) {
        $scope.step = Step.get({ manual_id: manualId, id: stepId });

        $scope.step.$promise.then(function (result) {
            $scope.form.data.name = result.name;
            $scope.list = result.blocks;
        });
    };

    $scope.saveForm = function () {
        $scope.step.name = $scope.form.data.name;
        Step.update({ manual_id: $scope.step.manual_id, id: $scope.step.id }, $scope.step);
        $scope.updateBlockBackend(true);
    };

    $scope.syncOrder = function (elemPositions) {
        $scope.loading = true;
        $scope.list.forEach(function (obj) {
            elemPositions.forEach(function (elemId, index) {
                var id = parseInt(elemId.replace(/object-/, ''));
                if (id === obj.id) {
                    obj.priority = index + 1;
                }
            });
        });
        $scope.updateBlockBackend();
        $scope.loading = false;
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
                $scope.addImage(model.link);
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

    $scope.addText = function () {
        $scope.loading = true;
        var markdown = new Block();
        markdown.content = "";
        markdown.priority = $scope.list.length + 1;
        markdown.step_id = $scope.step.id;
        Textes.create(markdown, function(response) {
            Block.get({id: response.id}).$promise.then(function (result) {
                $scope.list.push(result);
                $scope.loading = false;
            });
        });
    };

    $scope.addImage = function (link) {
        $scope.loading = true;
        var image = new Block();
        image.content = link;
        image.priority = $scope.list.length + 1;
        image.step_id = $scope.step.id;
        Images.create(image, function(response) {
            Block.get({ id: response.id }).$promise.then(function (result) {
                $scope.list.push(result);
                $scope.loading = false;
            });
        });
    };

    $scope.parseYoutubeUrl = function youtube_parser(url){
        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
        var match = url.match(regExp);
        return (match && match[7].length == 11)? match[7] : false;
    };

    $scope.addVideo = function () {
        var url = prompt('Youtube', "");
        var parsedData = $scope.parseYoutubeUrl(url);
        if (!parsedData)
        {
            return;
        }
        $scope.loading = true;
        var video = new Block();
        video.content = parsedData;
        video.priority = $scope.list.length + 1;
        video.step_id = $scope.step.id;
        Videos.create(video, function(response) {
            Block.get({id: response.id}).$promise.then(function (result) {
                $scope.list.push(result);
                $scope.loading = false;
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

    $scope.updateBlockBackend = function (onlyChange) {
        onlyChange = onlyChange || false;
        if (onlyChange)
        {
            $scope.updateChangedBlocks();
            return;
        }
        $scope.updateAllBlocks();
    };

    $scope.updateChangedBlocks = function () {
        $scope.list.forEach(function (obj) {
            if (obj.update)
            {
                $scope.updateBlock(obj);
            }
        });
    };

    $scope.updateAllBlocks = function () {
        $scope.list.forEach(function (obj) {
            $scope.updateBlock(obj);
        });
    };

    $scope.deleteBlock = function(block) {
        $scope.loading = true;
        var index = $scope.list.indexOf(block);
        var priority = block.priority;
        Block.delete({id: block.id}, function () {
            $scope.list.splice(index, 1);
            $scope.syncPositions(priority);
            $scope.updateBlockBackend();
            $scope.loading = false;
        });
    };

    $scope.updateBlock = function (block) {
        Block.update({ id: block.id }, block, function (response) { });
    };
}]);
