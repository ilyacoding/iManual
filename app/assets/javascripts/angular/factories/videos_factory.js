angular.module('app').factory('Videos', function ($resource) {
    return $resource('/api/videos', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
