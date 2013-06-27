$(document).ready(function() {
    $('.greenroof-list-hero-unit').each(function() {
        console.log("adding listener")
        $(this).click(function (event) {
            window.location.href = "/greenroofs/" + $(event.target).attr('data-id');
            console.log("click")
        })
    })
})