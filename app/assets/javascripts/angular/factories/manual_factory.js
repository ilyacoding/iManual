angular.module('app').factory('Manual', function ($resource) {
    return $resource('/manuals/:id.json', {}, {
        show: { method: 'GET' },
        update: { method: 'PUT', params: { id: '@id' } },
        delete: { method: 'DELETE', params: { id: '@id' } }
    })
});
