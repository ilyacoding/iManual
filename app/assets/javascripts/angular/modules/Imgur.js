(function($angular) {
    "use strict";

    var app = $angular.module('ngImgur', []);

    app.constant('imgurOptions', {
        UPLOAD_URL: 'https://api.imgur.com/3/image',
        UPLOAD_METHOD: 'POST',
        API_KEY: 'Client-ID 6cc23ba30a5dc03'
    });

    app.service('imgur', ImgurService);
    ImgurService.$inject = ['$window', '$http', '$q', 'imgurOptions'];

    function ImgurService($window, $http, $q, imgurOptions) {
        var service = {};

        service.setAPIKey = function setAPIKey(apiKey) {
            imgurOptions.API_KEY = apiKey;
        };

        service.upload = function upload(imageData) {
            if (!imgurOptions.API_KEY) {
                throw "ngImgur: You must define your API key in `imgurOptions.API_KEY`.";
            }

            if (!$angular.isArray(imageData)) {
                return this.send(imageData);
            }

            var defer = $q.defer(),
            promises = [];

            $angular.forEach(imageData, function forEach(imageModel) {
                promises.push(service.send(imageModel));

            });

            $q.all(promises).then(function then(resultModels) {
                defer.resolve(resultModels);
            });

            return defer.promise;
        };

        service.send = function send(imageData) {
            var reader = new $window.FileReader(),
                defer  = $q.defer();

            reader.onload = function onload(event) {
                var base64Data  = event.target.result.split(',')[1],
                    headerModel = { Authorization: imgurOptions.API_KEY },
                    dataModel   = { image: base64Data };

                var request = $http({
                    url:     imgurOptions.UPLOAD_URL,
                    method:  imgurOptions.UPLOAD_METHOD,
                    headers: headerModel,
                    data:    dataModel
                });

                request.then(function then(response) {
                    defer.resolve(response.data.data);
                });
            };

            reader.readAsDataURL(imageData);
            return defer.promise;
        };
        return service;
    }
})(window.angular);
