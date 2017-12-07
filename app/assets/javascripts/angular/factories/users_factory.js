angular.module('app').factory('Users', Users);

Users.$inject = ['$resource'];

function Users($resource) {
    return $resource('/users.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    });
}
