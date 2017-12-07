angular.module('app').factory('Manual', Manual);

Manual.$inject = ['$resource'];

function Manual($resource) {
    return $resource('/manuals/:id.json', {}, {
        show: { method: 'GET' },
        update: { method: 'PUT', params: { id: '@id' } },
        delete: { method: 'DELETE', params: { id: '@id' } }
    });
}
