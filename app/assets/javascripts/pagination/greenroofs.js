$(document).ready(function () {
    var paginator = new Pagination("greenroofs", 1, 20)

    paginator.getObjects(true)
    modalctrl = new ModalController()
    modalctrl.setListeners(paginator)

    $('.container').attr({
        style: "width: 75%"
    })
});

function ModalController() {
    this.groofId = 0
}

ModalController.prototype.setListeners = function (paginator) {

    $('#modal-cancel').click(function (event) {
        $('#confirm-modal').modal('hide')
    })

    $('#modal-accept').click(function (event) {
        acceptListenerAction(event)
    })

    function acceptListenerAction(event) {
        console.log(ModalController.groofId)
        $(event.target).attr('id', 'greenroofs/' + ModalController.groofId)
        paginator.deleteRequest(paginator)(event)
        $('#confirm-modal').modal('hide')
    }
}

var addElement = function (entry, admin) {
    var mainElement = $('<div></div>').attr('class', 'hero-unit greenroof-list-hero-unit span4');
    var thumbnailElement = $('<div></div>').attr('class', 'thumbnail pull-left')
    var thumbnail = $('<img />').attr('src', '/assets/ei_kuvaa_placeholder.gif')
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
        var removeElement = $('<img />').attr({
            src: '/assets/close-icon.png',
            class: 'close-icon',
            "data-toggle": 'modal',
            id: entry.id
        })

        removeElement.click(function () {
            $('#confirm-modal').modal('show')
            ModalController.groofId = entry.id

        })

        deleteElement.append(removeElement)
        mainElement.append(deleteElement)
        thumbnailElement.click(function () {
            window.location.href = "/greenroofs/" + entry.id;
        })
        thumbnailElement.attr('style', 'cursor: pointer;')
    } else {
        mainElement.click(function () {
            window.location.href = "/greenroofs/" + entry.id;
        })
        mainElement.attr('style', 'cursor: pointer;')
    }
    mainElement.append(infoElement)

    $('#hero-div').append(mainElement);
}