function Pagination(url, page, per_page, param) {

    if (param === undefined)  param = "";

    this.object = getObject()
    this.parameters = param
    this.url = url
    this.entry_count = 0;
    this.page = page
    this.per_page = per_page;
    this.total = 0

    function getObject() {
        return $('section[data-id="list-section"]').attr('data-object')
    }
}

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
            $('.alert').remove()
            paginator.getObjects(true)
        }
    }
})


Pagination.prototype.paginate = function () {
    var paginateBarListener = (function (paginator) {
        return function (event, page) {
            paginator.page = page
            paginator.getObjects()
        }
    })(this)

    $('.pagination').bootpag({
        total: this.total,   // total pages
        page: this.page,     // default page
        maxVisible: 10      // visible pagination
    }).on('page', paginateBarListener);
    $('.pagination').click(function () {
        $('.alert').remove()
    })
}

Pagination.prototype.getObjects = function (render) {

    if (render === undefined)  render = false;

    var paginator = this

    $.getJSON("/" + paginator.url + ".json?" + paginator.parameters + "page=" + paginator.page + "&per_page=" + paginator.per_page, function (data) {
        callbackHandler(data)
    });

    function callbackHandler(data) {

        paginator.entry_count = data["count"];

        var currentPages = Math.ceil(paginator.entry_count / paginator.per_page)

        if( currentPages < paginator.total ) {
            paginator.total = currentPages
            paginator.paginate()
        }

        paginator.total = currentPages

        var objects = data[ paginator.object + "s" ];
        if (objects.length === 0) {
            paginator.paginate()
        }
        if (render) {
            $('.pagination').empty()
            paginator.paginate()
            render = false;
        }

        // Clears the list.
        $('.' + paginator.object + '-list').empty();
        // And lists the queried objects.
        $.each(objects, function (i, item) {
            paginator.addElement(item, data["admin"]);
        });
    }
}

Pagination.prototype.addElement = addElement

