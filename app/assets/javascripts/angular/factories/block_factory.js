angular.module('app').factory('Block', Block);

Block.$inject = ['$resource'];

function Block($resource) {
    return $resource('/blocks/:id.json', {}, {
        show: { method: 'GET' },
        update: { method: 'PUT', params: { id: '@id' } },
        delete: { method: 'DELETE', params: { id: '@id' } }
    });
}
