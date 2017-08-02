angular.module('app').factory('Step', function ($resource) {
    return $resource('/manuals/:manual_id/steps/:id.json', {}, {
        show: { method: 'GET', params: { manual_id: '@manual_id', id: '@id' } },
        update: { method: 'PUT', params: { manual_id: '@manual_id', id: '@id' } },
        delete: { method: 'DELETE', params: { manual_id: '@manual_id', id: '@id' } }
    })
});
