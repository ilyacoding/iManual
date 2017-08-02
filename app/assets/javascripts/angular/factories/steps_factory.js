angular.module('app').factory('Steps', function ($resource) {
    return $resource('/manuals/:manual_id/steps.json', {}, {
        query: { method: 'GET', isArray: true, params: { manual_id: '@manual_id' } },
        create: { method: 'POST', params: { manual_id: '@manual_id' } }
    })
});
