angular.module('app').factory('Steps', function ($resource) {
    return $resource('/steps.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
