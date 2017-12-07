angular.module('app').factory('Textes', Textes);

Textes.$inject = ['$resource'];

function Textes($resource) {
    return $resource('/textes.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    });
}
