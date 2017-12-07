angular.module('app').factory('Categories', Categories);

Categories.$inject = ['$resource'];

function Categories($resource) {
    return $resource('/categories.json', {}, {
        get: { method: 'GET', isArray: true }
    });
}
