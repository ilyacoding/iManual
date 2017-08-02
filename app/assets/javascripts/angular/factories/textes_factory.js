angular.module('app').factory('Textes', function ($resource) {
    return $resource('/textes.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
