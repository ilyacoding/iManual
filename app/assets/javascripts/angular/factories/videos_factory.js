angular.module('app').factory('Videos', Videos);

Videos.$inject = ['$resource'];

function Videos($resource) {
    return $resource('/videos.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    });
}
