angular.module('app').factory('Categories', function ($resource) {
    return $resource('/categories.json', {}, {
        get: { method: 'GET', isArray: true }
    })
});
