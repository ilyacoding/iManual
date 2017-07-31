angular.module('app').factory('Images', function ($resource) {
    return $resource('/images.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
