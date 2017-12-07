angular.module('app').factory('Tags', Tags);

Tags.$inject = ['$resource'];

function Tags($resource) {
    return $resource('/tags.json', {}, {
        query: { method: 'GET', isArray: true, params: { manual_id: '@manual_id' } }
    });
}
