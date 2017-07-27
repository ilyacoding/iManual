angular.module('app').factory('Markdowns', function ($resource) {
    return $resource('/api/markdowns', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
