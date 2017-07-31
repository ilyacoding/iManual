angular.module('app').factory('Users', function ($resource) {
    return $resource('/users.json', {}, {
        query: { method: 'GET', isArray: true },
        create: { method: 'POST' }
    })
});
