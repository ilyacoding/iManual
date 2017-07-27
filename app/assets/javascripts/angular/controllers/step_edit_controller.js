angular.module('app').directive('imgUpload', ['$rootScope',function (rootScope) {
    return {
        restrict: 'A',
        link: function (scope, elem, attrs) {
            var canvas = document.createElement("canvas");
            var extensions = 'jpeg ,jpg, png, gif';
            elem.on('change', function () {
                reader.readAsDataURL(elem[0].files[0]);
                var filename = elem[0].files[0].name;

                var extensionlist = filename.split('.');
                var extension =extensionlist[extensionlist.length - 1];
                if(extensions.indexOf(extension) == -1){
                    alert("File extension , Only 'jpeg', 'jpg', 'png', 'gif', 'bmp' are allowed.");

                }else{
                    scope.file = elem[0].files[0];
                    scope.imageName = filename;
                }
            });

            var reader = new FileReader();
            reader.onload = function (e) {

                scope.image = e.target.result;
                scope.$apply();

            }
        }
    }
}]);
//     .directive("fileread", [function () {
//     return {
//         scope: {
//             fileread: "="
//         },
//         link: function (scope, element, attributes) {
//             element.bind("change", function (changeEvent) {
//                 var reader = new FileReader();
//                 reader.onload = function (loadEvent) {
//                     scope.$apply(function () {
//                         scope.fileread = loadEvent.target.result;
//                     });
//                 };
//                 reader.readAsDataURL(changeEvent.target.files[0]);
//             });
//         }
//     }
// }]);

angular.module('app').controller('StepEditCtrl', ['$scope', '$http', 'Step', 'Block', 'Markdowns', function ($scope, $http, Step, Block, Markdowns)
{

    $scope.image = null;
    $scope.imageFileName = '';

    $scope.uploadme = {};
    $scope.uploadme.src = '';

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

    // $scope.upload = function() {
    //     $http({
    //         headers: { Authorization: 'Client-ID 6cc23ba30a5dc03' },
    //         method: 'POST',
    //         url: 'https://api.imgur.com/3/image',
    //         dataType: 'json',
    //         data: {
    //             'image': $scope.uploadme.src,
    //             'type': 'base64'
    //         }
    //     }).then(function successCallback(response) {
    //         alert(JSON.stringify(response));
    //         // self.num = 2;
    //         // $log.log('called and successful', response);
    //     }, function errorCallback(err) {
    //         alert(JSON.stringify(err));
    //         console.log(err);
    //         // self.num = 3;
    //         // $log.log('called but error', err);
    //     });
    //
    //     // $.ajax({
    //     //     url: "https://api.imgur.com/3/upload",
    //     //     type: "POST",
    //     //     datatype: "json",
    //     //     data: {
    //     //         'image': iurl,
    //     //         'type': 'base64'
    //     //     },
    //     //     success: fdone,
    //     //     error: function(){
    //     //         $('#loader_img').hide();
    //     //         alert("failed");
    //     //     },
    //     //     beforeSend: function (xhr) {
    //     //         $('#loader_img').show();
    //     //         xhr.setRequestHeader("Authorization", "Client-ID " + clientId);
    //     //     }
    //     // });
    //
    // };

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
