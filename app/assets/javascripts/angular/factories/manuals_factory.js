angular.module('app').factory('Manuals', Manuals);

Manuals.$inject = ['$resource'];

function Manuals($resource) {
    return $resource('/manuals.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    });
}
