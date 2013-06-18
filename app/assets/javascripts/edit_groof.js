$(document).ready(function () {
    initalize()

    function initalize() {

        $('.remove-layer-button').each(function(index, element) {
            console.log($(this))
            $(this).click(removeParent)
        })
   }
});

