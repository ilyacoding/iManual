angular.module('app').controller('UserEditCtrl', UserEditCtrl);

UserEditCtrl.$inject = ['$scope', '$http', '$location', 'Users', 'User'];

function UserEditCtrl($scope, $http, $location, Users, User)
{
    $scope.form = {
        state: {},
        data: {}
    };

    $scope.initializeUser = function(userId) {
        $scope.user = User.get({id: userId});
    };

    $scope.saveForm = function () {
        $scope.updateUser();
    };

    $scope.updateUser = function () {
        User.update({ id: $scope.user.id }, $scope.user, function (response) {});
    };
}
