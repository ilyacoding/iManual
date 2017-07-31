angular.module('app').factory('Manuals', function ($resource) {
    return $resource('/manuals.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
