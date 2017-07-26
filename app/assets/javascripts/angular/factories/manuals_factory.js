angular.module('app').factory('Manuals', function ($resource) {
    return $resource('/api/manuals', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
