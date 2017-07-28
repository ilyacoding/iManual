angular.module('app').factory('Users', function ($resource) {
    return $resource('/api/users', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
