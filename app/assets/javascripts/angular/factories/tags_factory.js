angular.module('app').factory('Tags', function ($resource) {
    return $resource('/tags.json', {}, {
        query: { method: 'GET', isArray: true, params: { manual_id: '@manual_id' } }
    })
});
