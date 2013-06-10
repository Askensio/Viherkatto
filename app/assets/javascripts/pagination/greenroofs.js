$(document).ready(function () {
    var paginator = new Pagination("greenroofs", 1, 20)

    paginator.getObjects(true)

    $('#modal-cancel').click(function (event) {
        $('#confirm-modal').modal('hide')
    })

    $('#modal-accept').click(function (event) {
        $('#confirm-modal').modal('hide')
    })

    $('#modal-accept').click(paginator.deleteRequest(paginator))

});

var setAcceptButtonId = (function (id) {
    return function (event) {
        console.log(id)
        $('#modal-accept').attr('id', id)
        $('#confirm-modal').modal('show')
    }
})

var addElement = function (entry, admin) {
    var mainElement = $('<div></div>').attr('class', 'hero-unit greenroof-list-hero-unit span4');

    var thumbnailElement = $('<div></div>').attr('class', 'thumbnail pull-left')
    var thumbnail = $('<img />').attr('src', 'assets/ei_kuvaa_placeholder.gif')
    thumbnailElement.append(thumbnail)
    mainElement.append(thumbnailElement)

    var infoElement = $('<div></div>')
    var ownerHeading = $('<h5>Omistaja:</h5>')
    var owner = $('<p></p>').append(entry.user)
    infoElement.append(ownerHeading).append(owner)
    var addressHeading = $('<h5>Sijainti:</h5>')
    var address = $('<p></p>').append(entry.address)
    infoElement.append(addressHeading).append(address)

    if (admin) {
        var deleteElement = $('<a href=\"#\"\"></a>')
        deleteElement.attr('class', 'pull-right')
        //infoElement.append(deleteElement)

        //var removeElement = $('<i></i>').attr('class', 'icon-remove-circle')
        var removeElement = $('<img />').attr({
            src: 'assets/close-icon.png',
            class: 'close-icon',
            "data-toggle": 'modal',
            id: entry.id
        })

        // Shows confirmation dialoguen when clicking the cross in the corner
        removeElement.click(setAcceptButtonId(entry.id))

        //deleteElement.click(this.deleteRequest(this));
        deleteElement.append(removeElement)
        mainElement.append(deleteElement)
    }
    mainElement.append(infoElement)
    $('#hero-div').append(mainElement);
}