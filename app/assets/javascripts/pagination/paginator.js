function Pagination(url, page, per_page, param) {

    if (param === undefined)  param = "";

    this.object = getObject()
    this.parameters = param
    this.url = url
    this.entry_count = 0
    this.page = page
    this.per_page = per_page
    this.total = 0
    this.removeAlert = true

    // When paginate bar is clicked new objects are fetched from backend
    var paginateBarListener = (function (paginator) {
        return function (event) {
            paginator.getObjects()
        }
    })(this)

    // Binds the listener function into a click event listener
    $('.pagination').click(paginateBarListener)

    // When the bar is resized and reloaded (for example in a search) the current page of the paginator is set
    // to correspond the new active page
    var pageSetter = (function (paginator) {
        return function (event, page) {
            paginator.page = page
        }
    })(this)

    // Initializes the paginate bar and binds listeners
    $('.pagination').bootpag({
        total: this.total,   // total pages
        page: this.page,     // default page
        maxVisible: 10      // visible pagination
    }).on('page', pageSetter);


    // Gets the object class from the section identified by the id "list-section"
    function getObject() {
        return $('section[data-id="list-section"]').attr('data-object')
    }
}

// Creates a delete request for the server
Pagination.prototype.deleteRequest = (function (paginator) {

    return function (e) {
        var url = e.target.getAttribute('id')
        $.ajax({
            url: url,
            type: 'DELETE',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function (response) {
                callbackHandler(response)
            }
        });

        function callbackHandler(result) {
            var alert = $('<div></div>').attr('class', 'alert alert-' + result.response)
            if (result.response === 'success') {
                alert.append("Poisto onnistui.")
            }
            else {
                alert.append("Poisto epäonnistui.")
            }
            $('.pagination').before(alert)
            paginator.removeAlert = false

            paginator.getObjects()

            $('.pagination').empty()
            paginator.paginate()


        }
    }
})


Pagination.prototype.paginate = function () {

    // Sets new total amount of pages and the current pages for the paginator
    $('.pagination').bootpag({total: this.total, page: this.page });
}

// The render parameter tells if a repagination/re-render is needed. For example the initial call for getting objects
// is done by passing "true" as parameter since you want the paginate element to be rendered the first time.
Pagination.prototype.getObjects = function (render) {


    if (this.removeAlert) {
        $('.alert').remove()
    }

    this.removeAlert = true

    if (render === undefined)  render = false;

    var paginator = this

    // If a loading icon is present it will be shown until the callback function is invoked
    if ($('#loading-icon').length > 0) {
        // Clears the list.
        $('.' + paginator.object + '-list').empty()
        $('#loading-icon').attr('class', '')
    }

    // Makes the json query to the backend and invokes the callback handler function when ready
    $.getJSON("/" + paginator.url + ".json?" + paginator.parameters + "page=" + paginator.page + "&per_page=" + paginator.per_page, function (data) {
        callbackHandler(data)
    });

    function callbackHandler(data) {

        // if there is a loading icon present it will be hidden at this point
        if ($('#loading-icon').length > 0) {
            $('#loading-icon').attr('class', 'loading-icon')
        }

        // Gets the entry count from the json data
        paginator.entry_count = data["count"];

        // Calculates how many pages there should be currently
        var currentPages = Math.ceil(paginator.entry_count / paginator.per_page)

        // If there should be less pages visible than there currently is a new paginate is needed
        if (currentPages < paginator.total) {
            paginator.total = currentPages
            paginator.paginate()
        }

        //
        paginator.total = currentPages

        // Creates an array from the queried data
        var objects = data[ paginator.object + "s" ];
        if (objects.length === 0) {
            paginator.paginate()
        }
        // Re-renders the pagination tray
        if (render) {
            $('.pagination').empty()
            paginator.paginate()
            render = false;
        }

        // Clears the list.
        $('.' + paginator.object + '-list').empty()

        // Lists the queried objects.
        $.each(objects, function (i, item) {
            paginator.addElement(item, data["admin"]);
        });
    }
}

Pagination.prototype.addElement = addElement

