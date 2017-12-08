angular.module('app').factory('Categories', Categories);

Categories.$inject = ['$resource'];

function Categories($resource) {
    return $resource('/categories.json?locale=:locale', {}, {
        get: { method: 'GET', params: { locale: '@locale' }, isArray: true }
    });
}
