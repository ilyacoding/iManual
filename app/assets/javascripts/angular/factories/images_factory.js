angular.module('app').factory('Images', Images);

Images.$inject = ['$resource'];

function Images($resource) {
    return $resource('/images.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    });
}
