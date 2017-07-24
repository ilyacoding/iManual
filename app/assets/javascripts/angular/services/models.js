app.factory('Manual', function($resource) {
    return $resource('/manuals/:id', { id: '@id' }, {'update': { method: 'PUT' } });
});

app.factory('Page', function($resource) {
    return $resource('/manuals/:manualId/pages/:id', { manualId: '@manualId', id: '@id' });
});