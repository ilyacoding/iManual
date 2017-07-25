app.factory('Manual', function($resource) {
    return $resource('/manuals/:id', { id: '@id' }, {'update': { method: 'PUT' } });
});

app.factory('Step', function($resource) {
    return $resource('/manuals/:manualId/steps/:id', { manualId: '@manualId', id: '@id' }, {'update': { method: 'PUT' } });
});