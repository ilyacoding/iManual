angular.module('app').controller('StepEditCtrl', ['$scope', '$http', 'Step', 'Block', 'Markdowns', function ($scope, $http, Step, Block, Markdowns)
{
    $scope.getStep = function(stepId) {
        $scope.step = Step.get({id: stepId});

        $scope.step.$promise.then(function (result) {
            $scope.list = result.blocks;
            $scope.form.data.text = result.name;
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

    $scope.upload = function() {
        alert(1);
        $http({
            headers: {'Authorization': 'Client-ID da424dd9ff0afc3'},
            url: 'https://api.imgur.com/3/upload',
            type: 'POST',
            datatype: "json",
            data: {
                'image': $scope.img
            }
        }).then(function successCallback(response) {
            alert(JSON.stringify(response));
            // self.num = 2;
            // $log.log('called and successful', response);
        }, function errorCallback(err) {
            alert(JSON.stringify(err));
            // self.num = 3;
            // $log.log('called but error', err);
        });

        // $.ajax({
        //     url: "https://api.imgur.com/3/upload",
        //     type: "POST",
        //     datatype: "json",
        //     data: {
        //         'image': iurl,
        //         'type': 'base64'
        //     },
        //     success: fdone,
        //     error: function(){
        //         $('#loader_img').hide();
        //         alert("failed");
        //     },
        //     beforeSend: function (xhr) {
        //         $('#loader_img').show();
        //         xhr.setRequestHeader("Authorization", "Client-ID " + clientId);
        //     }
        // });

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

    $scope.addImage = function () {

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
        var priority = block.priority;
        Step.delete({id: block.id}, function () {
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
