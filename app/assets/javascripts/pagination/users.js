$(document).ready(function () {
    var paginator = new Pagination("users", 1, 20)

    paginator.getObjects(true)
    modalctrl = new ModalController()
    modalctrl.setListeners(paginator)
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
        $(event.target).attr('id', 'users/' + ModalController.groofId)
        paginator.deleteRequest(paginator)(event)
        $('#confirm-modal').modal('hide')
    }
}

var addElement = function (entry, admin) {
    var listElement = $('<li></li>').attr({
        style: "width: 30%"
    })
    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + entry.name + '</a>')
    listElement.append(link)
    var deleteElement = $('<a href=\"#\" id="/' + this.object + 's/' + entry.id + '\">' + 'poista' + '</a>').click(function (event) {
        event.stopPropagation()
        $('#confirm-modal').modal('show')
        ModalController.groofId = entry.id

    });
    deleteElement.attr('class', 'pull-right')
    listElement.append(deleteElement)
    $('.' + this.object + '-list').append(listElement)
}