angular.module('app').factory('User', User);

User.$inject = ['$resource'];

function User($resource) {
    return $resource('/users/:id.json', {}, {
        show: { method: 'GET' },
        update: { method: 'PUT', params: { id: '@id' } },
        delete: { method: 'DELETE', params: { id: '@id' } }
    });
}
