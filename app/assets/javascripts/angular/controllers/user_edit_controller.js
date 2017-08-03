angular.module('app').controller('UserEditCtrl', ['$scope', '$http', '$location', 'Users', 'User', function ($scope, $http, $location, Users, User)
{
    $scope.getUser = function(userId) {
        $scope.user = User.get({id: userId});
    };

    $scope.updateUser = function () {
        User.update({ id: $scope.user.id }, $scope.user, function (response) {});
    };

    $scope.cl = function () {

    };
}]);
