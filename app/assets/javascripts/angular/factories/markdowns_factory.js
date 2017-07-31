angular.module('app').factory('Markdowns', function ($resource) {
    return $resource('/markdowns.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
