$(document).ready(function () {
    var paginator = new Pagination("users", 1, 20)

    paginator.getObjects(true)
    modalctrl = new ModalController()
    modalctrl.setListeners(paginator)

    var clickListener = function (event) {
        paginate()
    }

    $('#find-button').click(clickListener);

    var keyListener = function (event) {
        var code = (event.keyCode ? event.keyCode : event.which);
        if (code == 13) { //Enter keycode
            paginate()
        }
    }

    $('#email-field').keyup(keyListener)

    function paginate() {
        var params = 'email=' + $('#email-field').val() + '&'
        paginator.parameters = params
        paginator.getObjects(true)
    }
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

function AdminController(id, elem) {

    this.id = id
    this.element = elem

    this.toggleAdminStatus
}
AdminController.prototype.toggleAdminStatus = function () {
    var element = this.element

    $.ajax({
        url: '/users/' + this.id + '/admin',
        type: 'POST',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: function (response) {
            responseHandler(response)
        }
    });

    function responseHandler(admin) {
        if (admin) {
            console.log("käyttäjä on admin")
            element.attr('class', 'admin-user user-controls')
        } else {
            console.log("käyttäjä ei ole admin")
            element.attr('class', 'user-controls')
        }
        console.log(element)
    }

    console.log("Changin admin status of id: " + this.id)
}

var addElement = function (entry, admin) {
    var listElement = $('<li></li>').attr({
        style: "width: 40%"
    })
    var userLink = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + entry.email + '</a>')
    listElement.append(userLink)

    var controlElement = $('<div></div>')

    var adminToggle = $('<label>admin</label>').attr('class', 'user-controls')
    if (entry.admin) {
        adminToggle.attr('class', 'admin-user user-controls')
    }

    adminToggle.click(function (event) {
        adminToggler = new AdminController(entry.id, $(event.target))
        adminToggler.toggleAdminStatus()
    })

    controlElement.append(adminToggle)

    controlElement.append(' | ')

    var deleteElement = $('<a href=\"#\" id="/' + this.object + 's/' + entry.id + '\">' + 'poista' + '</a>').click(function (event) {
        event.stopPropagation()
        $('#confirm-modal').modal('show')
        ModalController.groofId = entry.id

    });
    controlElement.append(deleteElement)

    controlElement.attr('class', 'pull-right')


    listElement.append(controlElement)

    $('.' + this.object + '-list').append(listElement)
}