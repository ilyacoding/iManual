angular.module('app').factory('Images', function ($resource) {
    return $resource('/api/images', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
