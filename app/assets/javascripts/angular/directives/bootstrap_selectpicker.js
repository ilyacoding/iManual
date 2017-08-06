angular.module('app').directive('bootstrapSelectpicker', function(){
    return {
        restrict : 'A',
        link: function(scope, element, attr){
            $(element).selectpicker();
        }
    };
});
