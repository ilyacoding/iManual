angular.module('app').factory('Steps', function ($resource) {
    return $resource('/api/steps', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
