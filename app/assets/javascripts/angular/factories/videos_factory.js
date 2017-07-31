angular.module('app').factory('Videos', function ($resource) {
    return $resource('/videos.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
